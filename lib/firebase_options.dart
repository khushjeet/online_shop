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
    apiKey: 'AIzaSyA83RqAAyP-pLv1XiS5Pl9QtViKsmWDESY',
    appId: '1:517187935378:web:bb3649318d4e1d226e1a4b',
    messagingSenderId: '517187935378',
    projectId: 'shop-24e2c',
    authDomain: 'shop-24e2c.firebaseapp.com',
    storageBucket: 'shop-24e2c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAyZNloq9rjoz0X5eotNzWQcGU3Fjl1Q4k',
    appId: '1:517187935378:android:96a865c6282f8b516e1a4b',
    messagingSenderId: '517187935378',
    projectId: 'shop-24e2c',
    storageBucket: 'shop-24e2c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZCMa9xhfNxgWM0x7xk6BI8Zp5VlK3mjk',
    appId: '1:517187935378:ios:aeae408f2632c6736e1a4b',
    messagingSenderId: '517187935378',
    projectId: 'shop-24e2c',
    storageBucket: 'shop-24e2c.appspot.com',
    iosBundleId: 'com.example.onlineShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCZCMa9xhfNxgWM0x7xk6BI8Zp5VlK3mjk',
    appId: '1:517187935378:ios:339dc8b70217e5ca6e1a4b',
    messagingSenderId: '517187935378',
    projectId: 'shop-24e2c',
    storageBucket: 'shop-24e2c.appspot.com',
    iosBundleId: 'com.example.onlineShop.RunnerTests',
  );
}
