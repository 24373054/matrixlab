// 页面切换功能
document.addEventListener('DOMContentLoaded', function() {
    // 获取所有侧边栏链接
    const sidebarLinks = document.querySelectorAll('#libdoc-sidebar-menu a[href]');
    
    // 为每个链接添加点击事件监听器
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            
            // 检查是否是内部页面链接（不是外部链接）
            if (href && !href.startsWith('http') && !href.startsWith('#') && href !== '/') {
                e.preventDefault();
                
                // 如果是"你好"页面或其他内部页面
                if (href === '/hello.html') {
                    loadPageContent('/hello.html');
                } else if (href.endsWith('.html') && href !== '/index.html') {
                    loadPageContent(href);
                }
            }
        });
    });
    
    // 初始化页面标题锚点特效
    initTitleAnchors();
});

// 加载页面内容的函数
function loadPageContent(url) {
    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.text();
        })
        .then(html => {
            // 解析返回的HTML
            const parser = new DOMParser();
            const doc = parser.parseFromString(html, 'text/html');
            
            // 获取主要内容区域
            const mainContent = doc.querySelector('main');
            
            if (mainContent) {
                // 替换当前页面的主要内容
                const currentMain = document.querySelector('main');
                if (currentMain) {
                    currentMain.innerHTML = mainContent.innerHTML;
                }
                
                // 更新页面标题
                const pageTitle = doc.querySelector('#libdoc-page-title');
                if (pageTitle) {
                    const currentTitle = document.querySelector('#libdoc-page-title');
                    if (currentTitle) {
                        currentTitle.textContent = pageTitle.textContent;
                    }
                }
                
                // 更新页面描述
                const pageDescription = doc.querySelector('header p');
                if (pageDescription) {
                    const currentDescription = document.querySelector('header p');
                    if (currentDescription) {
                        currentDescription.textContent = pageDescription.textContent;
                    }
                }
                
                // 更新URL（不刷新页面）
                window.history.pushState({}, '', url);
                
                // 重新初始化Prism语法高亮
                if (window.Prism) {
                    Prism.highlightAll();
                }
                
                // 重新初始化其他脚本
                initPageScripts();
            }
        })
        .catch(error => {
            console.error('Error loading page:', error);
            // 如果加载失败，正常跳转
            window.location.href = url;
        });
}

// 初始化页面脚本
function initPageScripts() {
    // 这里可以添加其他需要重新初始化的脚本
    if (typeof initToggles === 'function') {
        initToggles();
    }
    
    // 重新初始化标题锚点特效
    initTitleAnchors();
    
    // 重新初始化人员页面标签切换功能
    initPeopleTabs();
    
    // 更新侧边栏导航高亮状态
    updateSidebarActiveState();
}

// 初始化标题锚点特效
function initTitleAnchors() {
    // 移除可能已存在的锚点样式
    const existingStyle = document.querySelector('style[data-anchor-style]');
    if (existingStyle) {
        existingStyle.remove();
    }
    
    // 插入锚点样式
    const anchors_style = `
        <style data-anchor-style>
            main a.libdoc-anchor {
                position: absolute;
                transform: translateX(-150%) skewX(30deg);
                font-family: var(--sg-font-family-lead);
                opacity: 0;
                transition: opacity 300ms, transform 300ms;
            }
            main h1:not(#libdoc-page-title):hover > a.libdoc-anchor, 
            main h2:hover > a.libdoc-anchor, 
            main h3:hover > a.libdoc-anchor, 
            main h4:hover > a.libdoc-anchor, 
            main h5:hover > a.libdoc-anchor, 
            main h6:hover > a.libdoc-anchor {
                opacity: 1;
                transform: translateX(-110%) skewX(0deg);
            }
        </style>
    `;
    document.head.insertAdjacentHTML('beforeend', anchors_style);
    
    // 为所有标题添加锚点
    const el_content_titles_anchors = document.querySelectorAll('main h1:not(#libdoc-page-title), main h2, main h3, main h4, main h5, main h6');
    if (el_content_titles_anchors !== null) {
        el_content_titles_anchors.forEach(function(el) {
            // 如果标题已经有锚点，跳过
            if (el.querySelector('.libdoc-anchor')) {
                return;
            }
            
            // 确保标题有ID
            if (!el.id) {
                // 如果没有ID，创建一个基于文本内容的ID
                const text = el.textContent.trim().toLowerCase().replace(/[^\w\s]/gi, '').replace(/\s+/g, '-');
                el.id = text || 'heading-' + Math.random().toString(36).substr(2, 9);
            }
            
            const link_title = 'Permanent link to: ' + (document.title || 'LibDoc') + ' > ' + el.textContent;
            el.insertAdjacentHTML('afterbegin', '<a href="#' + el.id + '" class="libdoc-anchor" title="' + link_title + '">#</a>');
        });
    }
}

// 处理浏览器前进后退按钮
window.addEventListener('popstate', function(e) {
    // 当用户点击前进后退按钮时，重新加载页面内容
    loadPageContent(window.location.pathname);
});
