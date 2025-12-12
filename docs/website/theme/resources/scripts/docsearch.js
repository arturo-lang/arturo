// =============================================================================
// Fuse.js-powered Documentation Search
// =============================================================================

(function() {
    'use strict';

    // =============================================================================
    // STATE VARIABLES
    // =============================================================================

    let fuse = null;
    let searchData = [];
    let currentIndex = -1;
    let basePath = '';
    let useModal = false;
    let isDropdownHovered = false;
    
    // =============================================================================
    // DOM ELEMENTS & INITIALIZATION
    // =============================================================================

    const searchInput = document.getElementById('searchbar');
    const searchIcon = document.getElementById('searchbar-icon');
    
    const mobileSearchInput = document.getElementById('mobile-searchbar');
    const mobileSearchDropdown = document.getElementById('mobile-search-dropdown');
    const mobileSearchModal = document.getElementById('mobile-search-modal');
    const mobileSearchTrigger = document.querySelector('.mobile-search-trigger');
    const mobileSearchClose = document.querySelector('.mobile-search-close');
    const modalBackground = mobileSearchModal ? mobileSearchModal.querySelector('.modal-background') : null;
    
    if (!searchInput && !mobileSearchInput) return;

    let dropdown = null;
    if (searchInput) {
        dropdown = document.createElement('div');
        dropdown.id = 'search-dropdown';
        dropdown.className = 'search-dropdown';
        const icon = document.getElementById('searchbar-icon');
        searchInput.parentNode.insertBefore(dropdown, icon.nextSibling);

        dropdown.addEventListener('mouseenter', () => {
            isDropdownHovered = true;
        });

        dropdown.addEventListener('mouseleave', () => {
            isDropdownHovered = false;
        });
    }

    // =============================================================================
    // PUBLIC API
    // =============================================================================

    window.initDocSearch = function(showInModal) {
        basePath = '/%<[basePath]>%';
        useModal = showInModal || false;
        initSearch();
        
        if (useModal) {
            setupModalEventListeners();
        }
    };

    // =============================================================================
    // SEARCH INITIALIZATION
    // =============================================================================

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

    // =============================================================================
    // MODAL MANAGEMENT (for Playground)
    // =============================================================================

    function setupModalEventListeners() {
        const modal = document.getElementById('doc-modal');
        if (!modal) {
            console.error('Doc modal not found in HTML');
            return;
        }
        
        const closeBtn = document.getElementById('doc-modal-close');
        const background = modal.querySelector('.modal-background');
        
        const closeModal = () => {
            modal.classList.remove('is-active');
            document.documentElement.classList.remove('is-clipped');
        };
        
        closeBtn.addEventListener('click', closeModal);
        background.addEventListener('click', closeModal);
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modal.classList.contains('is-active')) {
                closeModal();
            }
        });
    }

    async function showDocInModal(url, title) {
        const modal = document.getElementById('doc-modal');
        const modalTitle = document.getElementById('doc-modal-title');
        const modalBody = document.getElementById('doc-modal-body');
        
        modal.classList.add('is-active');
        document.documentElement.classList.add('is-clipped');
        modalTitle.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="#000000" viewBox="0 0 256 256"><path d="M180,232a12,12,0,0,1-12,12H88a12,12,0,0,1,0-24h80A12,12,0,0,1,180,232Zm40-128a91.51,91.51,0,0,1-35.17,72.35A12.26,12.26,0,0,0,180,186v2a20,20,0,0,1-20,20H96a20,20,0,0,1-20-20v-2a12,12,0,0,0-4.7-9.51A91.57,91.57,0,0,1,36,104.52C35.73,54.69,76,13.2,125.79,12A92,92,0,0,1,220,104Zm-24,0a68,68,0,0,0-69.65-68C89.56,36.88,59.8,67.55,60,104.38a67.71,67.71,0,0,0,26.1,53.19A35.87,35.87,0,0,1,100,184h56.1A36.13,36.13,0,0,1,170,157.49,67.68,67.68,0,0,0,196,104Zm-20.07-5.32a48.5,48.5,0,0,0-31.91-40,12,12,0,0,0-8,22.62,24.31,24.31,0,0,1,16.09,20,12,12,0,0,0,23.86-2.64Z"></path></svg><span class="main-title">${title}</span><span class="doc-link"><a href="${url}" target="_blank">Open in new tab &gt;</a></span>`;
        modalBody.innerHTML = '<div class="has-text-centered"><div class="loader"></div></div>';
        
        try {
            const response = await fetch(url);
            if (!response.ok) throw new Error('Failed to load documentation');
            
            const html = await response.text();
            
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            
            const mainContent = doc.querySelector('.column.is-9.p-6.mb-6');
            
            if (mainContent) {
                const contentClone = mainContent.cloneNode(true);
                
                const breadcrumbs = contentClone.querySelector('nav.breadcrumb');
                if (breadcrumbs) {
                    breadcrumbs.remove();
                }
                
                const headings = contentClone.querySelectorAll('h4.title');
                headings.forEach(heading => {
                    if (heading.textContent.trim() === 'Related') {
                        const relatedHeading = heading;
                        const relatedContent = relatedHeading.nextElementSibling;
                        if (relatedContent) {
                            relatedContent.remove();
                        }
                        relatedHeading.remove();
                    }
                });
                
                const titleLevel = contentClone.querySelector('.level.mt-6.is-mobile');
                if (titleLevel) {
                    titleLevel.remove();
                }
                
                modalBody.innerHTML = contentClone.innerHTML;
                modalBody.classList.add('playground-modal-content');

                if (typeof Prism !== 'undefined') {
                    Prism.highlightAllUnder(modalBody);
                }

                const links = modalBody.querySelectorAll('a');
                links.forEach(link => {
                    const href = link.getAttribute('href');
                    if (!href) return;
                    
                    if (href.includes('/documentation/')) {
                        link.addEventListener('click', (e) => {
                            e.preventDefault();
                            const fullUrl = new URL(href, window.location.origin).href;
                            const linkText = link.textContent.trim();
                            showDocInModal(fullUrl, linkText);
                        });
                    } 
                    else if (href.startsWith('/') || href.includes(window.location.hostname)) {
                        link.setAttribute('target', '_blank');
                        link.setAttribute('rel', 'noopener');
                    }
                });
                
                if (typeof Clipboard !== 'undefined') {
                    const clipboard = new Clipboard('.copy');
                }
                
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

    // =============================================================================
    // SEARCH FUNCTIONALITY
    // =============================================================================

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
                
                if (item.name && item.name.toLowerCase().startsWith(queryLower)) {
                    bonus = 1000;
                }
                else if (item.name && item.name.toLowerCase().includes(queryLower)) {
                    bonus = 500;
                }
                
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
        
        if (results.length > 0) {
            setActiveResult(0);
        }
    }

    // =============================================================================
    // MOBILE SEARCH
    // =============================================================================

    function openMobileSearch() {
        if (!mobileSearchModal) return;
        mobileSearchModal.classList.add('is-active');
        document.documentElement.classList.add('is-clipped');
        setTimeout(() => {
            if (mobileSearchInput) mobileSearchInput.focus();
        }, 100);
    }

    function closeMobileSearch() {
        if (!mobileSearchModal) return;
        mobileSearchModal.classList.remove('is-active');
        document.documentElement.classList.remove('is-clipped');
        if (mobileSearchInput) mobileSearchInput.value = '';
        if (mobileSearchDropdown) {
            mobileSearchDropdown.innerHTML = '';
            mobileSearchDropdown.classList.remove('has-results');
        }
    }

    function performMobileSearch(query) {
        if (!fuse || !query || query.length < 2) {
            if (mobileSearchDropdown) {
                mobileSearchDropdown.innerHTML = '';
                mobileSearchDropdown.classList.remove('has-results');
            }
            return;
        }

        const queryLower = query.toLowerCase();
        const results = fuse.search(query)
            .map(result => {
                const item = result.item;
                let bonus = 0;
                
                if (item.name && item.name.toLowerCase().startsWith(queryLower)) {
                    bonus = 1000;
                }
                else if (item.name && item.name.toLowerCase().includes(queryLower)) {
                    bonus = 500;
                }
                
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
            
        displayMobileResults(results, query);
    }

    function displayMobileResults(results, query) {
        if (!mobileSearchDropdown) return;
        
        if (results.length === 0) {
            const noResultsHTML = `
                <div class="search-no-results">
                    <div class="search-no-results-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="1.5em" height="1.5em" fill="currentColor" viewBox="0 0 256 256"><path d="M128,20A108,108,0,1,0,236,128,108.12,108.12,0,0,0,128,20Zm0,192a84,84,0,1,1,84-84A84.09,84.09,0,0,1,128,212ZM108,108A16,16,0,1,1,92,92,16,16,0,0,1,108,108Zm72,0a16,16,0,1,1-16-16A16,16,0,0,1,180,108Z"></path></svg>
                    </div>
                    <div class="search-no-results-text">
                        No results found for<br>"<strong>${escapeHtml(query)}</strong>"
                    </div>
                </div>
            `;
            mobileSearchDropdown.innerHTML = noResultsHTML;
            requestAnimationFrame(() => {
                mobileSearchDropdown.classList.add('has-results');
            });
            return;
        }

        let resultsHTML = '';
        results.forEach((result) => {
            const item = result.item;
            resultsHTML += createMobileResultHTML(item, query, result.matches);
        });
        
        mobileSearchDropdown.innerHTML = resultsHTML;
        
        mobileSearchDropdown.querySelectorAll('.search-result-item').forEach(div => {
            div.addEventListener('click', (e) => {
                e.preventDefault();
                const url = div.getAttribute('data-url');
                const title = div.getAttribute('data-title');
                closeMobileSearch();
                navigateToResult(url, title);
            });
        });
        
        requestAnimationFrame(() => {
            mobileSearchDropdown.classList.add('has-results');
        });
    }

    function createMobileResultHTML(item, query, matches = []) {
        const nameMatch = matches.find(m => m.key === 'name');
        const descMatch = matches.find(m => m.key === 'desc');

        const queryLower = query.toLowerCase();
        const nameLower = item.name ? item.name.toLowerCase() : '';
        const hasNameMatch = nameLower.includes(queryLower);
        
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
        const url = basePath + '/documentation/' + item.url;
        const title = item.name;
        
        let contentHTML;
        if (matchedAttrKey !== null) {
            const highlightedAttrKey = highlightText(matchedAttrKey, queryLower);
            const highlightedAttrValue = highlightText(matchedAttrValue, queryLower);
            
            contentHTML = `
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
            const highlightedDesc = highlightFuseMatch(item.desc || '', descMatch);
            
            contentHTML = `
                <div class="search-result-content">
                    <div class="search-result-header">
                        <span class="search-result-name">${highlightedName}</span>
                        <span class="search-result-category">${item.modl}</span>
                    </div>
                    <div class="search-result-description">${highlightedDesc}</div>
                </div>
            `;
        }
        
        return `<div class="search-result-item" data-url="${url}" data-title="${escapeHtml(title)}">${contentHTML}</div>`;
    }

    // =============================================================================
    // RESULT ELEMENT CREATION
    // =============================================================================

    function createResultElement(item, index, query, matches = []) {
        const div = document.createElement('div');
        div.className = 'search-result-item';
        div.setAttribute('data-index', index);
        div.setAttribute('data-url', basePath + '/documentation/' + item.url);
        div.setAttribute('data-title', item.name);

        const nameMatch = matches.find(m => m.key === 'name');
        const descMatch = matches.find(m => m.key === 'desc');

        const queryLower = query.toLowerCase();
        const nameLower = item.name ? item.name.toLowerCase() : '';
        
        const hasNameMatch = nameLower.includes(queryLower);
        
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

        div.addEventListener('click', (e) => {
            e.preventDefault();
            navigateToResult(div.getAttribute('data-url'), div.getAttribute('data-title'));
        });

        div.addEventListener('mouseenter', () => {
            setActiveResult(index);
        });

        return div;
    }

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

    // =============================================================================
    // TEXT HIGHLIGHTING UTILITIES
    // =============================================================================

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

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // =============================================================================
    // DROPDOWN MANAGEMENT
    // =============================================================================

    function showDropdown() {
        if (!dropdown) return;
        dropdown.classList.add('is-active');
        searchInput.classList.add('keep-open');
    }

    function hideDropdown() {
        if (!dropdown) return;
        dropdown.classList.remove('is-active');
        dropdown.innerHTML = '';
        currentIndex = -1;
        if (!searchInput.matches(':focus')) {
            searchInput.classList.remove('keep-open');
        }
    }

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

    // =============================================================================
    // NAVIGATION
    // =============================================================================

    function navigateToResult(url, title) {
        if (searchInput) searchInput.value = '';
        
        if (useModal) {
            showDocInModal(url, title);
            hideDropdown();
        } else {
            window.location.href = url;
        }
    }

    // =============================================================================
    // KEYBOARD NAVIGATION
    // =============================================================================

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

    // =============================================================================
    // EVENT LISTENERS
    // =============================================================================

    if (searchInput) {
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

        searchInput.addEventListener('blur', () => {
            setTimeout(() => {
                if (!isDropdownHovered && !searchInput.matches(':focus')) {
                    searchInput.classList.remove('keep-open');
                    hideDropdown();
                }
            }, 200);
        });

        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
            }
        });
    }

    document.addEventListener('click', (e) => {
        if (searchInput && !searchInput.contains(e.target) && dropdown && !dropdown.contains(e.target)) {
            hideDropdown();
        }
    });

    if (mobileSearchTrigger) {
        mobileSearchTrigger.addEventListener('click', (e) => {
            e.preventDefault();
            openMobileSearch();
        });
    }

    if (mobileSearchClose) {
        mobileSearchClose.addEventListener('click', closeMobileSearch);
    }

    if (modalBackground) {
        modalBackground.addEventListener('click', closeMobileSearch);
    }

    if (mobileSearchInput) {
        let mobileSearchTimeout;
        
        mobileSearchInput.addEventListener('input', (e) => {
            clearTimeout(mobileSearchTimeout);
            const query = e.target.value.trim();
            
            if (query.length < 2) {
                if (mobileSearchDropdown) {
                    mobileSearchDropdown.innerHTML = '';
                    mobileSearchDropdown.classList.remove('has-results');
                }
                return;
            }
            
            mobileSearchTimeout = setTimeout(() => {
                performMobileSearch(query);
            }, 150);
        });

        mobileSearchInput.addEventListener('keydown', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                const firstResult = mobileSearchDropdown ? mobileSearchDropdown.querySelector('.search-result-item') : null;
                if (firstResult) {
                    const url = firstResult.getAttribute('data-url');
                    const title = firstResult.getAttribute('data-title');
                    closeMobileSearch();
                    navigateToResult(url, title);
                }
            } else if (e.key === 'Escape') {
                e.preventDefault();
                closeMobileSearch();
            }
        });
    }

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && mobileSearchModal && mobileSearchModal.classList.contains('is-active')) {
            closeMobileSearch();
        }
    });

})();