// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.env['apiKey_web'].toString(),
    appId: dotenv.env['appId_web'].toString(),
    messagingSenderId: dotenv.env['messagingSenderId_web'].toString(),
    projectId: dotenv.env['projectId_web'].toString(),
    authDomain: dotenv.env['authDomain_web'].toString(),
    storageBucket: dotenv.env['storageBucket_web'].toString(),
    measurementId: dotenv.env['measurementId_web'].toString(),
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['apiKey_mobile'].toString(),
    appId: dotenv.env['appId_mobile'].toString(),
    messagingSenderId: dotenv.env['messagingSenderId_mobile'].toString(),
    projectId: dotenv.env['projectId_mobile'].toString(),
    storageBucket: dotenv.env['storageBucket_mobile'].toString(),
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['apiKey_ios'].toString(),
    appId: dotenv.env['appId_ios'].toString(),
    messagingSenderId: dotenv.env['messagingSenderId_ios'].toString(),
    projectId: dotenv.env['projectId_ios'].toString(),
    storageBucket: dotenv.env['storageBucket_ios'].toString(),
    iosClientId: dotenv.env['iosClientId_ios'].toString(),
    iosBundleId: dotenv.env['iosBundleId_ios'].toString(),
  );
}
