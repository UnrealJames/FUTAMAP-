import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: "AIzaSyAMt6x8dT7_RBLpnbO_GZW4zrpOuOdsSrw",
    appId: '1:641927001428:android:72ae8f79a6fa3e880c44c1',
    messagingSenderId: '641927001428',
    projectId: "futa-map-bd9c9",
    storageBucket: "futa-map-bd9c9.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyAMt6x8dT7_RBLpnbO_GZW4zrpOuOdsSrw",
    appId: '1:641927001428:ios:54dc7bcd2db89f4f0c44c1',
    messagingSenderId: '641927001428',
    projectId: "futa-map-bd9c9",
    storageBucket: "futa-map-bd9c9.appspot.com",
    iosClientId:
        '641927001428-k9v2l409oset2o87djoq6kggrvntq1am.apps.googleusercontent.com',
    iosBundleId: 'com.certified.futamap',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyAMt6x8dT7_RBLpnbO_GZW4zrpOuOdsSrw",
    authDomain: "futa-map-bd9c9.firebaseapp.com",
    projectId: "futa-map-bd9c9",
    storageBucket: "futa-map-bd9c9.appspot.com",
    messagingSenderId: "641927001428",
    appId: "1:641927001428:web:7cfd3b74053f0b900c44c1",
    measurementId: "G-LMRSBW0PHL",
  );
}
