// Fuse.js-powered 
// Documentation Search
(function() {
    'use strict';

    let fuse = null;
    let searchData = [];
    let currentIndex = -1;
    let basePath = '';
    
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
                    { name: 'attr', weight: 0.3 },
                    { name: 'desc', weight: 0.2 },
                    { name: 'exam', weight: 0.05 },
                    { name: 'modl', weight: 0.05 }
                ],
                threshold: 0.35,
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

        const queryLower = query.toLowerCase();
        const results = fuse.search(query)
            .map(result => {
                const item = result.item;
                let bonus = 0;
                
                // Name starts with query?
                if (item.name && item.name.toLowerCase().startsWith(queryLower)) {
                    bonus = 1000;
                }
                // Name contains query?
                else if (item.name && item.name.toLowerCase().includes(queryLower)) {
                    bonus = 500;
                }
                
                // Attr key starts with query?
                if (item.attr && typeof item.attr === 'object') {
                    for (const key of Object.keys(item.attr)) {
                        if (key.toLowerCase().startsWith(queryLower)) {
                            bonus = Math.max(bonus, 900);
                            break;
                        }
                    }
                }
                
                return {
                    ...result,
                    adjustedScore: result.score - (bonus / 1000)
                };
            })
            .sort((a, b) => a.adjustedScore - b.adjustedScore)
            .slice(0, 8);
            
        displayResults(results, query);
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
        
        // Automatically select the first result
        if (results.length > 0) {
            setActiveResult(0);
        }
    }

    // Create result element
    function createResultElement(item, index, query, matches = []) {
        const div = document.createElement('div');
        div.className = 'search-result-item';
        div.setAttribute('data-index', index);
        div.setAttribute('data-url', basePath + '/documentation/' + item.url);

        const nameMatch = matches.find(m => m.key === 'name');
        const descMatch = matches.find(m => m.key === 'desc');
        const attrMatch = matches.find(m => m.key === 'attr');

        const queryLower = query.toLowerCase();
        const nameLower = item.name ? item.name.toLowerCase() : '';
        
        // Does name match?
        const hasNameMatch = nameLower.includes(queryLower);
        
        // Find attribute match
        let matchedAttrKey = null;
        let matchedAttrValue = null;
        
        if (!hasNameMatch && item.attr && typeof item.attr === 'object') {
            for (const [key, value] of Object.entries(item.attr)) {
                if (key.toLowerCase().includes(queryLower)) {
                    matchedAttrKey = key;
                    matchedAttrValue = String(value);
                    break;
                }
            }
        }

        const highlightedName = highlightFuseMatch(item.name, nameMatch);
        
        let html;
        if (matchedAttrKey !== null) {
            // Show attribute format with highlighting
            const highlightedAttrKey = highlightText(matchedAttrKey, queryLower);
            const highlightedAttrValue = highlightText(matchedAttrValue, queryLower);
            
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
            // Show normal format
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
            navigateToResult(div.getAttribute('data-url'));
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

    // Highlight query text in string
    function highlightText(text, query) {
        if (!text || !query) return escapeHtml(text);
        
        const textLower = text.toLowerCase();
        const index = textLower.indexOf(query);
        
        if (index === -1) return escapeHtml(text);
        
        const before = escapeHtml(text.slice(0, index));
        const match = escapeHtml(text.slice(index, index + query.length));
        const after = escapeHtml(text.slice(index + query.length));
        
        return `${before}<mark>${match}</mark>${after}`;
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
                // If no item selected, use first result
                const targetIndex = currentIndex >= 0 ? currentIndex : 0;
                if (items[targetIndex]) {
                    const url = items[targetIndex].getAttribute('data-url');
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
        }, 150);
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