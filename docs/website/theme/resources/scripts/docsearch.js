// Fuse.js-powered 
// Documentation Search
(function() {
    'use strict';

    let fuse = null;
    let searchData = [];
    let currentIndex = -1;
    let basePath = '';
    let useModal = false; // NEW: Track if we should use modal instead of navigation
    
    // DOM elements
    const searchInput = document.getElementById('searchbar');
    const searchIcon = document.getElementById('searchbar-icon');
    
    if (!searchInput) return;

    // Create dropdown container
    const dropdown = document.createElement('div');
    dropdown.id = 'search-dropdown';
    dropdown.className = 'search-dropdown';
    searchInput.parentNode.insertBefore(dropdown, searchInput.nextSibling);

    // Initialize search with base path and optional modal parameter
    window.initDocSearch = function(showInModal) {
        basePath = '/%<[basePath]>%';
        useModal = showInModal || false;
        initSearch();
        
        if (useModal) {
            createModalElement();
        }
    };

    // Create modal element for documentation display
    function createModalElement() {
        const modalHtml = `
            <div id="doc-modal" class="modal">
                <div class="modal-background"></div>
                <div class="modal-card" style="width: 90%; max-width: 1200px; max-height: 90vh;">
                    <header class="modal-card-head">
                        <p class="modal-card-title" id="doc-modal-title">Documentation</p>
                        <button class="delete" aria-label="close" id="doc-modal-close"></button>
                    </header>
                    <section class="modal-card-body doc-modal-content" id="doc-modal-body" style="border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
                        <div class="has-text-centered">
                            <span class="loader"></span>
                        </div>
                    </section>
                </div>
            </div>
        `;
        
        document.body.insertAdjacentHTML('beforeend', modalHtml);
        
        // Add event listeners
        const modal = document.getElementById('doc-modal');
        const closeBtn = document.getElementById('doc-modal-close');
        const closeBtnFooter = document.getElementById('doc-modal-close-btn');
        const openTabBtn = document.getElementById('doc-modal-open-tab');
        const background = modal.querySelector('.modal-background');
        
        let currentUrl = '';
        
        const closeModal = () => {
            modal.classList.remove('is-active');
            document.documentElement.classList.remove('is-clipped');
        };
        
        closeBtn.addEventListener('click', closeModal);
        closeBtnFooter.addEventListener('click', closeModal);
        background.addEventListener('click', closeModal);
        
        openTabBtn.addEventListener('click', () => {
            if (currentUrl) {
                window.open(currentUrl, '_blank');
            }
        });
        
        // Store current URL for the "Open in New Tab" button
        modal.addEventListener('doc-url-changed', (e) => {
            currentUrl = e.detail.url;
        });
        
        // Close modal on ESC key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modal.classList.contains('is-active')) {
                closeModal();
            }
        });
    }

    // Show documentation in modal
    async function showDocInModal(url, title) {
        const modal = document.getElementById('doc-modal');
        const modalTitle = document.getElementById('doc-modal-title');
        const modalBody = document.getElementById('doc-modal-body');
        
        // Show modal with loading state
        modal.classList.add('is-active');
        document.documentElement.classList.add('is-clipped');
        modalTitle.textContent = title || 'Documentation';
        modalBody.innerHTML = '<div class="has-text-centered"><div class="loader"></div></div>';
        
        // Dispatch event with current URL
        modal.dispatchEvent(new CustomEvent('doc-url-changed', { detail: { url } }));
        
        try {
            const response = await fetch(url);
            if (!response.ok) throw new Error('Failed to load documentation');
            
            const html = await response.text();
            
            // Parse the HTML to extract just the main content
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            
            // Extract the main content column (the documentation content)
            // Based on your structure, it's in: .column.is-9.p-6.mb-6
            const mainContent = doc.querySelector('.column.is-9.p-6.mb-6');
            
            if (mainContent) {
                // Clone the content
                const contentClone = mainContent.cloneNode(true);
                
                // Remove breadcrumbs navigation (first nav.breadcrumb element)
                const breadcrumbs = contentClone.querySelector('nav.breadcrumb');
                if (breadcrumbs) {
                    breadcrumbs.remove();
                }
                
                // Remove the "Related" section
                // Find the h4 with "Related" text and remove it + the following content div
                const headings = contentClone.querySelectorAll('h4.title');
                headings.forEach(heading => {
                    if (heading.textContent.trim() === 'Related') {
                        // Remove the heading
                        const relatedHeading = heading;
                        // Remove the next sibling (the content div with the list)
                        const relatedContent = relatedHeading.nextElementSibling;
                        if (relatedContent) {
                            relatedContent.remove();
                        }
                        relatedHeading.remove();
                    }
                });
                
                // Remove top margin from title
                const titleLevel = contentClone.querySelector('.level.mt-6.is-mobile');
                if (titleLevel) {
                    titleLevel.style.marginTop = '0rem';
                }
                
                modalBody.innerHTML = contentClone.innerHTML;
                
                modalBody.classList.add('playground-modal-content');
                
                // Make all links in the modal open in the same modal (if they're doc links)
                // or in new tabs (if they're external)
                const links = modalBody.querySelectorAll('a');
                links.forEach(link => {
                    const href = link.getAttribute('href');
                    if (!href) return;
                    
                    // If it's a documentation link, open in modal
                    if (href.includes('/documentation/')) {
                        link.addEventListener('click', (e) => {
                            e.preventDefault();
                            const fullUrl = new URL(href, window.location.origin).href;
                            const linkText = link.textContent.trim();
                            showDocInModal(fullUrl, linkText);
                        });
                    } 
                    // If it's an internal link but not documentation, open in new tab
                    else if (href.startsWith('/') || href.includes(window.location.hostname)) {
                        link.setAttribute('target', '_blank');
                        link.setAttribute('rel', 'noopener');
                    }
                    // External links already work fine
                });
                
                // Initialize copy buttons if they exist
                if (typeof Clipboard !== 'undefined') {
                    const clipboard = new Clipboard('.copy');
                }
                
                // Scroll modal body to top
                modalBody.scrollTop = 0;
                
            } else {
                modalBody.innerHTML = '<div class="notification is-warning">Could not extract documentation content.</div>';
            }
            
        } catch (error) {
            console.error('Error loading documentation:', error);
            modalBody.innerHTML = `
                <div class="notification is-danger">
                    <strong>Error loading documentation</strong><br>
                    ${error.message}
                </div>
            `;
        }
    }

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
        div.setAttribute('data-title', item.name);

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
            navigateToResult(div.getAttribute('data-url'), div.getAttribute('data-title'));
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
                    <svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" viewBox="0 0 256 256"><path d="M128,20A108,108,0,1,0,236,128,108.12,108.12,0,0,0,128,20Zm0,192a84,84,0,1,1,84-84A84.09,84.09,0,0,1,128,212ZM108,108A16,16,0,1,1,92,92,16,16,0,0,1,108,108Zm72,0a16,16,0,1,1-16-16A16,16,0,0,1,180,108Z"></path></svg>
                </div>
                <div class="search-no-results-text">
                    No results found for<br>"<strong>${escapeHtml(query)}</strong>"
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

    // Navigate to result - use modal if enabled, otherwise normal navigation
    function navigateToResult(url, title) {
        if (useModal) {
            showDocInModal(url, title);
            hideDropdown(); // Close the search dropdown
        } else {
            window.location.href = url;
        }
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
                    const title = items[targetIndex].getAttribute('data-title');
                    navigateToResult(url, title);
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