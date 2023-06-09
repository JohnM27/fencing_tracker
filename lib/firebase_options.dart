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
    apiKey: 'AIzaSyA7EYmO9yKnL2XeWtd13tMZvezC5kgfnPU',
    appId: '1:438715667872:web:13a7e11be13b1b88c440c5',
    messagingSenderId: '438715667872',
    projectId: 'fencing-tracker',
    authDomain: 'fencing-tracker.firebaseapp.com',
    databaseURL:
        'https://fencing-tracker-default-rtdb.europe-west1.firebasedatabase.app/', //'https://fencing-tracker.firebaseio.com',
    storageBucket: 'fencing-tracker.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCs2ZPtJDMh6mf7F8M2ZznKnhjQT0svtnI',
    appId: '1:438715667872:android:5906b5b9ada70dd7c440c5',
    messagingSenderId: '438715667872',
    projectId: 'fencing-tracker',
    storageBucket: 'fencing-tracker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBtKeSMGPurKlmf7D0X5WCwOOEp1cHCVwE',
    appId: '1:438715667872:ios:03fb1f8a45ddf6dcc440c5',
    messagingSenderId: '438715667872',
    projectId: 'fencing-tracker',
    storageBucket: 'fencing-tracker.appspot.com',
    iosClientId:
        '438715667872-ri9tae1qh4qarfrdmtt8dibd3hcppvmo.apps.googleusercontent.com',
    iosBundleId: 'com.example.fencingTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBtKeSMGPurKlmf7D0X5WCwOOEp1cHCVwE',
    appId: '1:438715667872:ios:a54634a664ee745bc440c5',
    messagingSenderId: '438715667872',
    projectId: 'fencing-tracker',
    storageBucket: 'fencing-tracker.appspot.com',
    iosClientId:
        '438715667872-vm7pbsd9ffs4imn6b7hu7ls8toco3u0k.apps.googleusercontent.com',
    iosBundleId: 'com.example.fencingTracker.RunnerTests',
  );
}
