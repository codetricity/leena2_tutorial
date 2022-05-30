'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/push.json": "9d8fb7460f34c20d0795e24a0416ef95",
"assets/assets/jump.tps": "55fbfe65b4c30ee758bce192fffb5676",
"assets/assets/tiles/map2.tmx": "1aa98586c919efa4027034f45f4acb27",
"assets/assets/tiles/map.tmx": "44c2221f51ba6c9d48fa409af86c621e",
"assets/assets/idle.tps": "6deaaa126d8f49411f3e9c56592c5b56",
"assets/assets/ride.tps": "3a19a018a954b23714135e3361751c27",
"assets/assets/push.tps": "3275dd32f690b7023bb6f6295919caa3",
"assets/assets/ride.json": "a8d6bf9f75df3b4a0499a187ce7f6b4c",
"assets/assets/images/ground_tiles.png": "2580aa6ed9279673837a5fcf27768da0",
"assets/assets/images/background.png": "25d5be3073245a2c56c82ffec7d50822",
"assets/assets/images/ride.png": "5beed70c908b5d83b41213dc69195439",
"assets/assets/images/dad.png": "aeb522a7b6d2a6bde733233ae78bea9d",
"assets/assets/images/ground_tiles/18.png": "abee4b0e43728d2bcc9aa475d8271814",
"assets/assets/images/ground_tiles/9.png": "b4a0102fc6244aa9a2371d4ffc4755cb",
"assets/assets/images/ground_tiles/11.png": "44567d5195045f2d8f8ea5b95ba1d500",
"assets/assets/images/ground_tiles/12.png": "2494896a1798e459b2c22abc084f1ee9",
"assets/assets/images/ground_tiles/15.png": "f6cc90a105c047f7f36e06310556fa53",
"assets/assets/images/ground_tiles/4.png": "5ee43fdff799e7697bd9cc4651f9243a",
"assets/assets/images/ground_tiles/2.png": "e37e3eb18e99d696a99d9a976f6a16a3",
"assets/assets/images/ground_tiles/7.png": "0c0f8c64614e27c46332825247b628eb",
"assets/assets/images/ground_tiles/10.png": "ed3ef2d00251e825ed909cebdf535c5c",
"assets/assets/images/ground_tiles/5.png": "2176876e24331c17c3f5f0c4ac568288",
"assets/assets/images/ground_tiles/13.png": "134f22337fca7f428ec71fd43eebe0ce",
"assets/assets/images/ground_tiles/1.png": "9a3892e81908666bdf2152413da4f6fa",
"assets/assets/images/ground_tiles/3.png": "a6a01f1151660b5902f94e2612bca469",
"assets/assets/images/ground_tiles/6.png": "3f6c0116f9759744d512ef475a35196c",
"assets/assets/images/ground_tiles/14.png": "02cb90a2043d199b51ebf2634930a409",
"assets/assets/images/ground_tiles/16.png": "93a2fa9316c9b66b71b71aa16d14a8d2",
"assets/assets/images/ground_tiles/17.png": "90ed1f45d1db62d1fee8884675c190a8",
"assets/assets/images/ground_tiles/8.png": "6e7df435c1f51f5ed5a9e8db9cadbdac",
"assets/assets/images/ground_objects.xcf": "30a20a685d4f0c92c7daf02d0d56427f",
"assets/assets/images/idle.png": "7dadab333d63b6f8e620c16c68bf20d1",
"assets/assets/images/push.png": "43e8a256963499f7e06e656d703d1889",
"assets/assets/images/ground_obj.json": "b5bdaaa6c410eb2304c35d5091fbb8ef",
"assets/assets/images/girl.png": "95e1a758b8cae88b16e08a637d18e8a5",
"assets/assets/images/ground_objects.png": "a4dd03e7c97a0345265b3e090f1f83f8",
"assets/assets/images/jump.png": "b377835eebcd9071d4cec9326a8529c3",
"assets/assets/images/ground_tiles.json": "50b1e00e92fa662ed74a330567da2bb8",
"assets/assets/images/gems/GoldenIngot.png": "6a306b56447e2ee393ff2c92e7418a46",
"assets/assets/images/gems/Diamond.png": "bdb841fd8f6e2276a36d5364f816955c",
"assets/assets/images/gems/CutEmerald.png": "3916b4b6d12269c6849ed913f615f298",
"assets/assets/images/gems/GoldNugget.png": "66e37002eaf8defbf1326f695fc6a86a",
"assets/assets/images/gems/Crystal.png": "b7225bb140db41a59e2af8330fa2da58",
"assets/assets/images/gems/Sapphire.png": "bd3bc1b64747d8c369440ece319f3420",
"assets/assets/images/gems/CutSapphire.png": "1e5bc2b02bf31ebe82bb29a37f0e116b",
"assets/assets/images/gems/CutTopaz.png": "2f2c0225e382e2fc23e2d3d35a893b47",
"assets/assets/images/gems/SilverNugget.png": "1e95af434bc5e5db2e83fe922873d2a6",
"assets/assets/images/gems/SilverIngot.png": "d9149e743a250c59c43b8d20f57224d5",
"assets/assets/images/gems/Topaz.png": "0a5885d283ee206f42605e5f3a7c21c7",
"assets/assets/images/gems/Emerald.png": "49018bf55b4b6bae593523f7663ffccc",
"assets/assets/images/gems/Obsidian.png": "81d54c67baac9a4e33df50279bc8c83e",
"assets/assets/images/gems/Pearl.png": "defd603c4d24d449e23cec6ed7b4d83e",
"assets/assets/images/gems/Coal.png": "2783c759044b650e52e310681b311972",
"assets/assets/images/gems/CopperNugget.png": "a903db0736d13a3a23f5b58f374fcf77",
"assets/assets/images/gems/Ruby.png": "ff2992c8b3ec3264dafb1e4d9725a719",
"assets/assets/images/gems/CopperIngot.png": "3c0e12cbdee888db4f902d01ffb340bd",
"assets/assets/audio/sfx/bonus.wav": "57ae9b34e270e588a7f5b32e9fad1346",
"assets/assets/audio/sfx/yay.mp3": "83fb505664c75ad87259b46d71306220",
"assets/assets/idle.json": "78fd2823d40ab89ea5a5823d12a5acc8",
"assets/assets/fonts/ARCADECLASSIC.TTF": "964111990ca3937960147b80e8d07e61",
"assets/assets/jump.json": "05efb031dcb78dc24ff2e423f6f41532",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/AssetManifest.json": "9d810e6d3e08d6355525c737283503b4",
"assets/FontManifest.json": "43363627961752c1d7d8fd6901fab885",
"assets/NOTICES": "359ffcd549359b84586101dc3d21e7b4",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"main.dart.js": "1699f2ab4af912026ea245a0d88fd5ef",
"version.json": "f0ce38900e30c5a42508dc483e4626b9",
"index.html": "20765943aae826364ddba758e812e43c",
"/": "20765943aae826364ddba758e812e43c",
"manifest.json": "908700442fb20b6d598715e8dfa8ee57",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
