
// // File generated by FlutLab.
// import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
// import 'package:flutter/foundation.dart'
//     show defaultTargetPlatform, kIsWeb, TargetPlatform;

// class DefaultFirebaseOptions {
//   static FirebaseOptions get currentPlatform {
//     if (kIsWeb) {
//       throw UnsupportedError(
//         'DefaultFirebaseOptions have not been configured for web - '
//         'try to add using FlutLab Firebase Configuration',
//       );
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//         return android;
//       case TargetPlatform.iOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for iOS - '
//           'try to add using FlutLab Firebase Configuration',
//         );
//       case TargetPlatform.macOS:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for macos - '
//           'it not supported by FlutLab yet, but you can add it manually',
//         );
//       case TargetPlatform.windows:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for windows - '
//           'it not supported by FlutLab yet, but you can add it manually',
//         );
//       case TargetPlatform.linux:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions have not been configured for linux - '
//           'it not supported by FlutLab yet, but you can add it manually',
//         );
//       default:
//         throw UnsupportedError(
//           'DefaultFirebaseOptions are not supported for this platform.',
//         );
//     }
//   }

//   static const FirebaseOptions android = FirebaseOptions(
//     apiKey: 'AIzaSyA7ceoCTs2CGr8czNSNjJ9KB2NCFW-d33E',
//     appId: '1:256799517051:android:00ca4d3216a17fcb6375de',
//     messagingSenderId: '256799517051',
//     projectId: 'ecommsignin',
//     storageBucket: 'ecommsignin.appspot.com'
//   );
// }

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static const FirebaseOptions currentPlatform = FirebaseOptions(
    apiKey: "AIzaSyD42ZrcqXd48aHpYKtHBhGfXEHxYBZ8oOI",
  authDomain: "mobileapp-7e054.firebaseapp.com",
  projectId: "mobileapp-7e054",
  storageBucket: "mobileapp-7e054.firebasestorage.app",
  messagingSenderId: "203089479843",
  appId: "1:203089479843:web:5dcfdff4993352e8691716",
  );
}
