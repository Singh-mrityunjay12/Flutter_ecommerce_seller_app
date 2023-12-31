// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBv_mz60-Lz5yBefQ7GF-7dQM4RYQGeqM0',
    appId: '1:1001139849122:web:97717c2da94262436214fb',
    messagingSenderId: '1001139849122',
    projectId: 'emart-seller-app-6eb78',
    authDomain: 'emart-seller-app-6eb78.firebaseapp.com',
    storageBucket: 'emart-seller-app-6eb78.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYtOKSXNkuP4AhpdjGa1XVI655jeY7YFs',
    appId: '1:1001139849122:android:b1a2fb22f90314cb6214fb',
    messagingSenderId: '1001139849122',
    projectId: 'emart-seller-app-6eb78',
    storageBucket: 'emart-seller-app-6eb78.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1QIxsoubgkI1EW-YSFXBR2BHbN-qs58Y',
    appId: '1:1001139849122:ios:84debe18987b22bb6214fb',
    messagingSenderId: '1001139849122',
    projectId: 'emart-seller-app-6eb78',
    storageBucket: 'emart-seller-app-6eb78.appspot.com',
    iosBundleId: 'com.example.emartSeller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1QIxsoubgkI1EW-YSFXBR2BHbN-qs58Y',
    appId: '1:1001139849122:ios:84debe18987b22bb6214fb',
    messagingSenderId: '1001139849122',
    projectId: 'emart-seller-app-6eb78',
    storageBucket: 'emart-seller-app-6eb78.appspot.com',
    iosBundleId: 'com.example.emartSeller',
  );
}
