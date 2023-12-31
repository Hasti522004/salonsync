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
    apiKey: 'AIzaSyAWe5ejm3a1d6VDlA_h01unocfeV6GRKl0',
    appId: '1:44386611939:web:100024ee4a107636aa0bd6',
    messagingSenderId: '44386611939',
    projectId: 'salonsync-ea187',
    authDomain: 'salonsync-ea187.firebaseapp.com',
    storageBucket: 'salonsync-ea187.appspot.com',
    measurementId: 'G-DQJX6VYYQ9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDe5gMra1whlVOXhh-dVrRUDhXSoGpq2SU',
    appId: '1:44386611939:android:a3438522b261a5c9aa0bd6',
    messagingSenderId: '44386611939',
    projectId: 'salonsync-ea187',
    storageBucket: 'salonsync-ea187.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmpmKIiRM_GL1Xqe8Y-sGJq5UWICXjrHs',
    appId: '1:44386611939:ios:5a30cb115cf503d4aa0bd6',
    messagingSenderId: '44386611939',
    projectId: 'salonsync-ea187',
    storageBucket: 'salonsync-ea187.appspot.com',
    iosBundleId: 'com.example.salonsync',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmpmKIiRM_GL1Xqe8Y-sGJq5UWICXjrHs',
    appId: '1:44386611939:ios:9ec184bcbdb26d7faa0bd6',
    messagingSenderId: '44386611939',
    projectId: 'salonsync-ea187',
    storageBucket: 'salonsync-ea187.appspot.com',
    iosBundleId: 'com.example.salonsync.RunnerTests',
  );
}
