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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUS6mYM1DVph8c-N407iA-cRWqZlW2gAQ',
    appId: '1:895621519005:android:f7e8cecb0f3bc91a876674',
    messagingSenderId: '895621519005',
    projectId: 'fir-auth-fd178',
    storageBucket: 'fir-auth-fd178.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIleU5KxfvKfPSupgv9y_ulgeXqtr-OAM',
    appId: '1:895621519005:ios:6da4f2aebba54998876674',
    messagingSenderId: '895621519005',
    projectId: 'fir-auth-fd178',
    storageBucket: 'fir-auth-fd178.appspot.com',
    androidClientId: '895621519005-vh1r6j5f51ce9b5dqr7bmcpb5e0lnst5.apps.googleusercontent.com',
    iosClientId: '895621519005-j1h9vcv65ma0s9a8epg3nkh80scu7r38.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthApp',
  );
}
