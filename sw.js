// Service Worker for Matrix Lab
const CACHE_VERSION = 'v2';
const CACHE_NAME = `matrixlab-${CACHE_VERSION}`;

// 需要预缓存的关键资源
const PRECACHE_URLS = [
  '/',
  '/index.html',
  '/publications.html',
  '/people.html',
  '/assets/libdoc/css/normalize.css',
  '/assets/libdoc/css/libdoc.css',
  '/assets/libdoc/fonts/RedHatDisplay-Regular.woff2',
  '/assets/libdoc/fonts/RedHatDisplay-Bold.woff2',
  '/assets/libdoc/js/jquery-3.5.1.slim.min.js',
  '/assets/libdoc/js/my-toggles.js',
  '/assets/libdoc/js/template.js',
  '/assets/logo.gif'
];

// 安装事件：预缓存关键资源
self.addEventListener('install', event => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => cache.addAll(PRECACHE_URLS))
      .then(() => self.skipWaiting())
  );
});

// 激活事件：清理旧缓存
self.addEventListener('activate', event => {
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    }).then(() => self.clients.claim())
  );
});

// 获取事件：混合缓存策略
self.addEventListener('fetch', event => {
  // 只缓存GET请求
  if (event.request.method !== 'GET') {
    return;
  }

  // 跳过API请求
  if (event.request.url.includes('/api/')) {
    return;
  }

  const url = new URL(event.request.url);
  
  // 对publications.html使用网络优先策略（数据可能更新）
  if (url.pathname === '/publications.html' || url.pathname === '/publications') {
    event.respondWith(
      fetch(event.request)
        .then(response => {
          // 更新缓存
          if (response && response.status === 200) {
            caches.open(CACHE_NAME).then(cache => {
              cache.put(event.request, response.clone());
            });
          }
          return response;
        })
        .catch(() => {
          // 网络失败时使用缓存
          return caches.match(event.request);
        })
    );
    return;
  }

  // 其他资源使用缓存优先策略
  event.respondWith(
    caches.match(event.request)
      .then(cachedResponse => {
        if (cachedResponse) {
          // 后台更新缓存
          fetch(event.request).then(response => {
            if (response && response.status === 200) {
              caches.open(CACHE_NAME).then(cache => {
                cache.put(event.request, response.clone());
              });
            }
          });
          return cachedResponse;
        }

        // 如果缓存中没有，从网络获取
        return fetch(event.request).then(response => {
          // 检查是否是有效响应
          if (!response || response.status !== 200 || response.type === 'error') {
            return response;
          }

          // 克隆响应并存入缓存
          const responseToCache = response.clone();
          caches.open(CACHE_NAME).then(cache => {
            cache.put(event.request, responseToCache);
          });

          return response;
        });
      })
  );
});

