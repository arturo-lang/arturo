// Documentation Search powered by Fuse.js
(function() {
    'use strict';

    let fuse = null;
    let searchData = [];
    let currentIndex = -1;
    
    // DOM elements
    const searchInput = document.getElementById('searchbar');
    const searchIcon = document.getElementById('searchbar-icon');
    
    if (!searchInput) return;

    // Create dropdown container
    const dropdown = document.createElement('div');
    dropdown.id = 'search-dropdown';
    dropdown.className = 'search-dropdown';
    searchInput.parentNode.insertBefore(dropdown, searchInput.nextSibling);

    // Load search data and initialize Fuse
    async function initSearch() {
        try {
            const response = await fetch('/search-data.json');
            searchData = await response.json();
            
            fuse = new Fuse(searchData, {
                keys: [
                    { name: 'name', weight: 0.4 },
                    { name: 'fullName', weight: 0.3 },
                    { name: 'description', weight: 0.2 },
                    { name: 'searchText', weight: 0.1 }
                ],
                threshold: 0.3,
                includeScore: true,
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

        const results = fuse.search(query, { limit: 8 });
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
            const resultEl = createResultElement(item, index, query);
            dropdown.appendChild(resultEl);
        });

        showDropdown();
    }

    // Create result element
    function createResultElement(item, index, query) {
        const div = document.createElement('div');
        div.className = 'search-result-item';
        div.setAttribute('data-index', index);
        div.setAttribute('data-url', item.url);

        // Highlight matching text
        const highlightedName = highlightMatch(item.name, query);
        const highlightedDesc = highlightMatch(item.description, query);

        div.innerHTML = `
            <div class="search-result-content">
                <div class="search-result-header">
                    <span class="search-result-name">${highlightedName}</span>
                    <span class="search-result-category">${item.category}</span>
                </div>
                <div class="search-result-description">${highlightedDesc}</div>
            </div>
        `;

        // Click handler
        div.addEventListener('click', (e) => {
            e.preventDefault();
            navigateToResult(item.url);
        });

        // Hover handler
        div.addEventListener('mouseenter', () => {
            setActiveResult(index);
        });

        return div;
    }

    // Highlight matching text
    function highlightMatch(text, query) {
        if (!query) return text;
        
        const regex = new RegExp(`(${escapeRegex(query)})`, 'gi');
        return text.replace(regex, '<mark>$1</mark>');
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

    // Initialize on load
    initSearch();
})();