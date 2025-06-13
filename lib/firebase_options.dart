import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAKlvFOo2bzDwGAjGoB97Yz5fqi4gvBd9Y',
    appId: '1:267673672727:web:5a41cb0c26017048c55052',
    messagingSenderId: '267673672727',
    projectId: 'unlocker-938eb',
    authDomain: 'unlocker-938eb.firebaseapp.com',
    storageBucket: 'unlocker-938eb.firebasestorage.app',
    measurementId: 'G-N99CP8WBF4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDa2PaJfgLccdUAmK1okV9WXJEVOdKr9UU',
    appId: '1:267673672727:android:d6ad3aac71a74ed7c55052',
    messagingSenderId: '267673672727',
    projectId: 'unlocker-938eb',
    storageBucket: 'unlocker-938eb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOaXlL4YL0cJXWTrm0dvh8Dg6t8eBD_4c',
    appId: '1:267673672727:ios:c1f1068e03047b2ec55052',
    messagingSenderId: '267673672727',
    projectId: 'unlocker-938eb',
    storageBucket: 'unlocker-938eb.firebasestorage.app',
    iosBundleId: 'com.example.projetoUnloucker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCOaXlL4YL0cJXWTrm0dvh8Dg6t8eBD_4c',
    appId: '1:267673672727:ios:c1f1068e03047b2ec55052',
    messagingSenderId: '267673672727',
    projectId: 'unlocker-938eb',
    storageBucket: 'unlocker-938eb.firebasestorage.app',
    iosBundleId: 'com.example.projetoUnloucker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAKlvFOo2bzDwGAjGoB97Yz5fqi4gvBd9Y',
    appId: '1:267673672727:web:3c919a953382735bc55052',
    messagingSenderId: '267673672727',
    projectId: 'unlocker-938eb',
    authDomain: 'unlocker-938eb.firebaseapp.com',
    storageBucket: 'unlocker-938eb.firebasestorage.app',
    measurementId: 'G-Q2Z9QKRX8G',
  );
}
