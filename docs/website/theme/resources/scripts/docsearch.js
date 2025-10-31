// Documentation Search powered by Fuse.js
(function() {
    'use strict';

    let fuse = null;
    let searchData = [];
    let currentIndex = -1;
    let basePath = ''; // Will be set by initialization
    
    // DOM elements
    const searchInput = document.getElementById('searchbar');
    const searchIcon = document.getElementById('searchbar-icon');
    
    if (!searchInput) return;

    // Create dropdown container
    const dropdown = document.createElement('div');
    dropdown.id = 'search-dropdown';
    dropdown.className = 'search-dropdown';
    searchInput.parentNode.insertBefore(dropdown, searchInput.nextSibling);

    // Initialize search with base path
    window.initDocSearch = function(basePathValue = '') {
        basePath = basePathValue;
        initSearch();
    };

    // Load search data and initialize Fuse
    async function initSearch() {
        try {
            const response = await fetch(basePath + '/resources/data/index.json');
            searchData = await response.json();
            
            fuse = new Fuse(searchData, {
                keys: [
                    { name: 'name', weight: 0.4 },
                    { name: 'desc', weight: 0.2 },
                    { name: 'attr', weight: 0.2 },
                    { name: 'exam', weight: 0.1 },
                    { name: 'modl', weight: 0.4 }
                ],
                threshold: 0.4,
                //distance: 50,
                includeScore: true,
                includeMatches: true,
                minMatchCharLength: 2,
                ignoreLocation: true,
                shouldSort: true
            });
            
            console.log('Search initialized with', searchData.length, 'entries');
        } catch (error) {
            console.error('Failed to load search data:', error);
        }
    }

    // Perform search
    function performSearch(query) {
        if (!fuse || !query || query.length < 2) {
            hideDropdown();
            return;
        }

        const results = fuse.search(query, { limit: 20 }); // Get more results initially
        
        // Sort results with custom scoring that prioritizes exact matches
        const sortedResults = results
            .map(result => {
                const item = result.item;
                const queryLower = query.toLowerCase();
                let exactMatchBonus = 0;
                
                // Check for exact matches in various fields
                if (item.name && item.name.toLowerCase() === queryLower) {
                    exactMatchBonus = 1000; // Highest priority
                } else if (item.name && item.name.toLowerCase().includes(queryLower)) {
                    exactMatchBonus = 500; // Partial name match
                }
                
                // Check attributes for exact match
                if (item.attr && typeof item.attr === 'object') {
                    for (const [key, value] of Object.entries(item.attr)) {
                        if (key.toLowerCase() === queryLower) {
                            exactMatchBonus = Math.max(exactMatchBonus, 900); // Very high priority for exact attr key match
                            break;
                        } else if (key.toLowerCase().includes(queryLower)) {
                            exactMatchBonus = Math.max(exactMatchBonus, 400); // Partial attr key match
                        }
                    }
                }
                
                // Create adjusted score (lower is better in Fuse.js)
                const adjustedScore = (result.score || 0) - (exactMatchBonus / 1000);
                
                return {
                    ...result,
                    adjustedScore,
                    exactMatchBonus
                };
            })
            .sort((a, b) => a.adjustedScore - b.adjustedScore) // Sort by adjusted score
            .slice(0, 8); // Take top 8
        
        displayResults(sortedResults, query);
    }

    // Display search results
    function displayResults(results, query) {
        if (results.length === 0) {
            showNoResults(query);
            return;
        }

        dropdown.innerHTML = '';
        currentIndex = -1;

        results.forEach((result, index) => {
            const item = result.item;
            const resultEl = createResultElement(item, index, query, result.matches);
            dropdown.appendChild(resultEl);
        });

        showDropdown();
    }

    // Create result element
    function createResultElement(item, index, query, matches = []) {
        const div = document.createElement('div');
        div.className = 'search-result-item';
        div.setAttribute('data-index', index);
        // Always use the parent item's URL, even for attribute matches
        div.setAttribute('data-url', basePath + '/' + item.url);

        const nameMatch = matches.find(m => m.key === 'name');
        const descMatch = matches.find(m => m.key === 'desc');
        const attrMatch = matches.find(m => m.key === 'attr');

        // Check if this is an attribute match
        let matchedAttrKey = null;
        let matchedAttrValue = null;
        
        if (item.attr && typeof item.attr === 'object') {
            const queryLower = query.toLowerCase();
            const queryTerms = queryLower.split(/\s+/).filter(t => t.length > 0);
            
            // First pass: look for exact key matches
            for (const [key, value] of Object.entries(item.attr)) {
                const keyLower = key.toLowerCase();
                if (queryTerms.some(term => keyLower === term || keyLower.includes(term))) {
                    matchedAttrKey = key;
                    matchedAttrValue = String(value);
                    break;
                }
            }
            
            // Second pass: if no key match, look in values
            if (!matchedAttrKey) {
                for (const [key, value] of Object.entries(item.attr)) {
                    const valueLower = String(value).toLowerCase();
                    if (queryTerms.some(term => valueLower.includes(term))) {
                        matchedAttrKey = key;
                        matchedAttrValue = String(value);
                        break;
                    }
                }
            }
        }

        const highlightedName = highlightFuseMatch(item.name, nameMatch);
        
        // Build HTML based on whether it's an attr match or regular match
        let html;
        if (matchedAttrKey !== null && matchedAttrValue !== null) {
            // Attribute match - show name.attr and attr description
            const highlightedAttrKey = highlightMatch(matchedAttrKey, query);
            const highlightedAttrValue = highlightMatch(matchedAttrValue, query);
            
            html = `
                <div class="search-result-content">
                    <div class="search-result-header">
                        <span class="search-result-name">
                            ${highlightedName}<span class="search-result-attr-key">.${highlightedAttrKey}</span>
                        </span>
                        <span class="search-result-category">${item.modl}</span>
                    </div>
                    <div class="search-result-description search-result-attr-desc">${highlightedAttrValue}</div>
                </div>
            `;
        } else {
            // Regular match - show name and description
            const highlightedDesc = highlightFuseMatch(item.desc || '', descMatch);
            
            html = `
                <div class="search-result-content">
                    <div class="search-result-header">
                        <span class="search-result-name">${highlightedName}</span>
                        <span class="search-result-category">${item.modl}</span>
                    </div>
                    <div class="search-result-description">${highlightedDesc}</div>
                </div>
            `;
        }
        
        div.innerHTML = html;

        // Click handler
        div.addEventListener('click', (e) => {
            e.preventDefault();
            navigateToResult(basePath + '/' + item.url);
        });

        // Hover handler
        div.addEventListener('mouseenter', () => {
            setActiveResult(index);
        });

        return div;
    }

    // Highlight matching text using Fuse.js match indices
    function highlightFuseMatch(text, match) {
        if (!match || !match.indices) return escapeHtml(text);

        let result = '';
        let lastIndex = 0;

        match.indices.forEach(([start, end]) => {
            result += escapeHtml(text.slice(lastIndex, start));
            result += `<mark>${escapeHtml(text.slice(start, end + 1))}</mark>`;
            lastIndex = end + 1;
        });

        result += escapeHtml(text.slice(lastIndex));
        return result;
    }

    // Highlight matching text using simple string matching (for attr keys/values)
    function highlightMatch(text, query) {
        if (!query) return escapeHtml(text);
        
        const queryTerms = query.toLowerCase().split(/\s+/).filter(t => t.length > 0);
        let result = escapeHtml(text);
        
        queryTerms.forEach(term => {
            const regex = new RegExp(`(${escapeRegex(term)})`, 'gi');
            result = result.replace(regex, '<mark>$1</mark>');
        });
        
        return result;
    }

    // Escape regex special characters
    function escapeRegex(str) {
        return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    }

    // Show no results message
    function showNoResults(query) {
        dropdown.innerHTML = `
            <div class="search-no-results">
                <div class="search-no-results-icon">
                    <i class="fa fa-search"></i>
                </div>
                <div class="search-no-results-text">
                    No results found for "<strong>${escapeHtml(query)}</strong>"
                </div>
            </div>
        `;
        showDropdown();
    }

    // Escape HTML
    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Show dropdown
    function showDropdown() {
        dropdown.classList.add('is-active');
    }

    // Hide dropdown
    function hideDropdown() {
        dropdown.classList.remove('is-active');
        dropdown.innerHTML = '';
        currentIndex = -1;
    }

    // Set active result
    function setActiveResult(index) {
        const items = dropdown.querySelectorAll('.search-result-item');
        items.forEach((item, i) => {
            if (i === index) {
                item.classList.add('is-active');
                currentIndex = index;
                // Scroll into view if needed
                item.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
            } else {
                item.classList.remove('is-active');
            }
        });
    }

    // Navigate to result
    function navigateToResult(url) {
        window.location.href = url;
    }

    // Keyboard navigation
    function handleKeyboard(e) {
        const items = dropdown.querySelectorAll('.search-result-item');
        
        if (items.length === 0) return;

        switch(e.key) {
            case 'ArrowDown':
                e.preventDefault();
                currentIndex = Math.min(currentIndex + 1, items.length - 1);
                setActiveResult(currentIndex);
                break;
            
            case 'ArrowUp':
                e.preventDefault();
                currentIndex = Math.max(currentIndex - 1, 0);
                setActiveResult(currentIndex);
                break;
            
            case 'Enter':
                e.preventDefault();
                if (currentIndex >= 0 && items[currentIndex]) {
                    const url = items[currentIndex].getAttribute('data-url');
                    navigateToResult(url);
                }
                break;
            
            case 'Escape':
                e.preventDefault();
                hideDropdown();
                searchInput.blur();
                break;
        }
    }

    // Event listeners
    let searchTimeout;
    searchInput.addEventListener('input', (e) => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            performSearch(e.target.value.trim());
        }, 150); // Debounce
    });

    searchInput.addEventListener('keydown', handleKeyboard);

    searchInput.addEventListener('focus', () => {
        if (searchInput.value.trim().length >= 2) {
            performSearch(searchInput.value.trim());
        }
    });

    // Close dropdown when clicking outside
    document.addEventListener('click', (e) => {
        if (!searchInput.contains(e.target) && !dropdown.contains(e.target)) {
            hideDropdown();
        }
    });

    // Prevent form submission
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
        }
    });
})();