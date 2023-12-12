// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
//
//
//
// class Login2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login dengan Google'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             User? user = await signInWithGoogle();
//             if (user != null) {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DashboardPage(user: user),
//                 ),
//               );
//             } else {
//               print('Login gagal');
//             }
//           },
//           child: Text('Login dengan Google'),
//         ),
//       ),
//     );
//   }
// }
//
// class DashboardPage extends StatelessWidget {
//   final User user;
//
//   DashboardPage({required this.user});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Selamat datang,'),
//             Text(
//               user.email ?? '',
//               style: TextStyle(fontSize: 16),
//             ),
//             Text(
//               user.displayName ?? user.email ?? 'User',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await signOut();
//                 Navigator.pop(context); // Kembali ke halaman login setelah logout
//               },
//               child: Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Future<User?> signInWithGoogle() async {
//   try {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     if (googleUser == null) return null;
//
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);
//     final User? user = authResult.user;
//     return user;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }
//
// Future<void> signOut() async {
//   await FirebaseAuth.instance.signOut();
// }
