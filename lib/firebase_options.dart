import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
show defaultTargetPlatform, kIsWeb, TargetPlatform;


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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvFOFrI9bq6Qagee9QcUZY8l6SYF54_Lg',
    appId: '1:595163256812:web:659c73eeec7bcbc9e852c9',
    messagingSenderId: '595163256812',
    projectId: 'paybill-gerenciadordecontas',
    authDomain: 'paybill-gerenciadordecontas.firebaseapp.com',
    storageBucket: 'paybill-gerenciadordecontas.appspot.com',
    measurementId: 'G-MPM35ED698',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBJAMloG5RihT0Ibvve6k0G-BMovoEU2SI',
    appId: '1:595163256812:android:831893a612f8f18ce852c9',
    messagingSenderId: '595163256812',
    projectId: 'paybill-gerenciadordecontas',
    storageBucket: 'paybill-gerenciadordecontas.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQ7bPB16yluFjV-nH5ep_7z7Khk4w_Om4',
    appId: '1:595163256812:ios:ccecbb879fe24c1ce852c9',
    messagingSenderId: '595163256812',
    projectId: 'paybill-gerenciadordecontas',
    storageBucket: 'paybill-gerenciadordecontas.appspot.com',
    iosBundleId: 'com.example.payBill',
  );
}
