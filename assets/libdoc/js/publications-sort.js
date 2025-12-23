// Publications sorting functionality
let originalPublicationsOrder = null; // Store original order

document.addEventListener('DOMContentLoaded', function() {
    // Create sorting buttons
    const publicationsHeader = document.querySelector('#libdoc-page-title');
    if (publicationsHeader && publicationsHeader.textContent.trim() === 'Publications') {
        saveOriginalOrder(); // Save original order before any sorting
        createSortingButtons();
    }
});

function saveOriginalOrder() {
    const publicationsContainer = document.querySelector('#libdoc-content');
    const publications = [];
    
    // Find all publication elements (h3 headings)
    const publicationElements = publicationsContainer.querySelectorAll('h3');
    
    publicationElements.forEach(pubElement => {
        const publication = {
            element: pubElement.cloneNode(true),
            title: pubElement.textContent,
            year: extractYear(pubElement),
            citations: extractCitations(pubElement)
        };
        
        // Collect all related elements (authors, journal, conference, year, citations)
        let nextElement = pubElement.nextElementSibling;
        publication.relatedElements = [];
        
        while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
            publication.relatedElements.push(nextElement.cloneNode(true));
            nextElement = nextElement.nextElementSibling;
        }
        
        publications.push(publication);
    });
    
    originalPublicationsOrder = publications;
}

function createSortingButtons() {
    const header = document.querySelector('#libdoc-page-title').parentElement;
    
    // Create button container with compact styling
    const buttonContainer = document.createElement('div');
    buttonContainer.className = 'u-mb-sm';
    buttonContainer.innerHTML = `
        <div class="c-grid m-gap-xs m-wrap">
            <button id="sort-by-citations" class="c-btn m-tab u-fs-xs">
                <span class="i-sort-amount-desc u-mr-xs"></span>
                Sort by Citations
            </button>
            <button id="sort-by-year" class="c-btn m-tab u-fs-xs">
                <span class="i-calendar u-mr-xs"></span>
                Sort by Year
            </button>
            <button id="sort-default" class="c-btn m-tab u-fs-xs">
                <span class="i-list u-mr-xs"></span>
                Default Sort
            </button>
        </div>
    `;
    
    header.parentNode.insertBefore(buttonContainer, header.nextSibling);
    
    // Add event listeners
    document.getElementById('sort-by-citations').addEventListener('click', sortByCitations);
    document.getElementById('sort-by-year').addEventListener('click', sortByYear);
    document.getElementById('sort-default').addEventListener('click', sortDefault);
}

function sortByCitations() {
    const publicationsContainer = document.querySelector('#libdoc-content');
    const publications = [];
    
    // Find all publication elements (h3 headings)
    const publicationElements = publicationsContainer.querySelectorAll('h3');
    
    publicationElements.forEach(pubElement => {
        const publication = {
            element: pubElement,
            title: pubElement.textContent,
            year: extractYear(pubElement),
            citations: extractCitations(pubElement)
        };
        
        // Collect all related elements (authors, journal, conference, year, citations)
        let nextElement = pubElement.nextElementSibling;
        publication.relatedElements = [];
        
        while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
            publication.relatedElements.push(nextElement);
            nextElement = nextElement.nextElementSibling;
        }
        
        publications.push(publication);
    });
    
    // Sort by citations (descending)
    publications.sort((a, b) => {
        const citationsA = a.citations || 0;
        const citationsB = b.citations || 0;
        return citationsB - citationsA;
    });
    
    // Rebuild the publications list
    rebuildPublicationsList(publications, 'Sort by Citations');
}

function sortByYear() {
    const publicationsContainer = document.querySelector('#libdoc-content');
    const publications = [];
    
    // Find all publication elements (h3 headings)
    const publicationElements = publicationsContainer.querySelectorAll('h3');
    
    publicationElements.forEach(pubElement => {
        const publication = {
            element: pubElement,
            title: pubElement.textContent,
            year: extractYear(pubElement),
            citations: extractCitations(pubElement)
        };
        
        // Collect all related elements (authors, journal, conference, year, citations)
        let nextElement = pubElement.nextElementSibling;
        publication.relatedElements = [];
        
        while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
            publication.relatedElements.push(nextElement);
            nextElement = nextElement.nextElementSibling;
        }
        
        publications.push(publication);
    });
    
    // Sort by year (descending)
    publications.sort((a, b) => b.year - a.year);
    
    // Rebuild the publications list
    rebuildPublicationsList(publications, 'Sort by Year');
}

function sortDefault() {
    // Instead of reloading, restore the original order
    if (originalPublicationsOrder) {
        // Create a deep copy to avoid modifying the original
        const publications = originalPublicationsOrder.map(pub => ({
            element: pub.element.cloneNode(true),
            title: pub.title,
            year: pub.year,
            citations: pub.citations,
            relatedElements: pub.relatedElements.map(el => el.cloneNode(true))
        }));
        
        rebuildPublicationsList(publications, 'Default Sort');
    }
}

function extractYear(publicationElement) {
    let nextElement = publicationElement.nextElementSibling;
    while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
        if (nextElement.tagName === 'P') {
            const text = nextElement.textContent;
            // Match "Year:" pattern
            const yearMatch = text.match(/Year:\s*(\d{4})/);
            if (yearMatch) {
                return parseInt(yearMatch[1]);
            }
        }
        nextElement = nextElement.nextElementSibling;
    }
    return 0;
}

function extractCitations(publicationElement) {
    let nextElement = publicationElement.nextElementSibling;
    while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
        if (nextElement.tagName === 'P') {
            const text = nextElement.textContent;
            // Match both "Citations:" and "**Citations:**" patterns
            const citationMatch = text.match(/(?:\*\*)?Citations(?:\*\*)?:\s*(\d+)/);
            if (citationMatch) {
                return parseInt(citationMatch[1]);
            }
        }
        nextElement = nextElement.nextElementSibling;
    }
    return 0;
}

function rebuildPublicationsList(publications, sortType) {
    const publicationsContainer = document.querySelector('#libdoc-content');
    
    // Find Research Areas and Contact Information sections
    let researchAreas = null;
    let contactInfo = null;
    
    // Find all h2 and h3 elements to locate Research Areas and Contact Information
    const allHeadings = publicationsContainer.querySelectorAll('h2, h3');
    allHeadings.forEach(heading => {
        if (heading.textContent.includes('Research Areas')) {
            researchAreas = heading;
        } else if (heading.textContent.includes('Contact Information')) {
            contactInfo = heading;
        }
    });
    
    // Remove existing publications content (keep Research Areas and Contact Information)
    const yearSections = publicationsContainer.querySelectorAll('h2');
    yearSections.forEach(section => {
        if (!section.textContent.includes('Research Areas') && !section.textContent.includes('Contact Information')) {
            let nextElement = section.nextElementSibling;
            while (nextElement && nextElement.tagName !== 'H2') {
                const toRemove = nextElement;
                nextElement = nextElement.nextElementSibling;
                toRemove.remove();
            }
            section.remove();
        }
    });
    
    // Remove all h3 publication elements and their descriptions
    const publicationElements = publicationsContainer.querySelectorAll('h3');
    publicationElements.forEach(pubElement => {
        let nextElement = pubElement.nextElementSibling;
        while (nextElement && nextElement.tagName !== 'H3' && nextElement.tagName !== 'H2') {
            const toRemove = nextElement;
            nextElement = nextElement.nextElementSibling;
            toRemove.remove();
        }
        pubElement.remove();
    });
    
    // Create new publications list without year sections
    const insertBeforeElement = researchAreas || contactInfo || null;
    publications.forEach(pub => {
        publicationsContainer.insertBefore(pub.element, insertBeforeElement);
        // Insert all related elements (authors, journal, conference, year, citations)
        if (pub.relatedElements && pub.relatedElements.length > 0) {
            pub.relatedElements.forEach(element => {
                publicationsContainer.insertBefore(element, insertBeforeElement);
            });
        }
    });
}
