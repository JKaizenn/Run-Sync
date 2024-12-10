// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC93ZPnCXy5ButoxZaNcWi2z2cY2yNRDWo',
    appId: '1:698853298771:ios:a7b706bb9b74b6cc4a6ca6',
    messagingSenderId: '698853298771',
    projectId: 'run-sync-a7625',
    storageBucket: 'run-sync-a7625.firebasestorage.app',
    iosClientId: '698853298771-mtunul1v1ns3q2d78qa8c6489ndos225.apps.googleusercontent.com',
    iosBundleId: 'com.example.runSync',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC93ZPnCXy5ButoxZaNcWi2z2cY2yNRDWo',
    appId: '1:698853298771:ios:a7b706bb9b74b6cc4a6ca6',
    messagingSenderId: '698853298771',
    projectId: 'run-sync-a7625',
    storageBucket: 'run-sync-a7625.firebasestorage.app',
    iosClientId: '698853298771-mtunul1v1ns3q2d78qa8c6489ndos225.apps.googleusercontent.com',
    iosBundleId: 'com.example.runSync',
  );
}
