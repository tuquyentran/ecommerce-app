// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_app/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthServices {
  static final AuthServices instance = AuthServices();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SignUpUserWithEmailAndPassword
  signUpUserWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        return 'success';
      } else {
        return 'Sign up failed. Unknown error.';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return 'Sign up failed: ${e.message}';
      }
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  //SignIn
  signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        return 'success';
      } else {
        return 'Sign in failed. Unknown error.';
      }
    } on FirebaseAuthException catch (e) {
      return 'Wrong email or password.';
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

  //forget pw
  sendPasswordResetEmail({required String email}) async {
    try {
      final credential =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {      
      return 'An error occurred while sending the password reset email. Please try again later. ${e.message}';
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }

//   Future<String> signupUserWithEmailAndPassword({
//     required String email,
//     required String password,
//     required String name,
//   }) async {
//     String res = "Some error Occurred";
//     try {
//       if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
//         // register user in auth with email and password
//         UserCredential cred = await _auth.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         // add user to your  firestore database
//         print(cred.user!.uid);
//         await _firestore.collection("users").doc(cred.user!.uid).set({
//           'name': name,
//           'uid': cred.user!.uid,
//           'email': email,
//           'provider': 'email',
//         });

//         res = "success";
//       }
//     } catch (err) {
//       return err.toString();
//     }
//     return res;
//   }

//   Future<UserCredential?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser != null) {
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);

//       await _firestore
//           .collection("users")
//           .doc(userCredential.user!.uid)
//           .set({
//         'name': userCredential.user?.displayName ?? '',
//         'uid': userCredential.user?.uid,
//         'email': userCredential.user?.email,
//         'provider': 'google',
//       });

//       return userCredential;
//     } else {
//       print("Google Sign-in cancelled");
//       return null;
//     }
//   }

//   Future<UserCredential> signInWithFacebook(BuildContext context) async {
//     // Trigger the sign-in flow
//     final LoginResult loginResult = await FacebookAuth.instance.login();

//     // Create a credential from the access token
//     final OAuthCredential facebookAuthCredential =
//         FacebookAuthProvider.credential(
//             '${loginResult.accessToken?.tokenString}');

//     // Once signed in, return the UserCredential
//     UserCredential userCredential = await FirebaseAuth.instance
//         .signInWithCredential(facebookAuthCredential);

//     await _firestore
//         .collection("users")
//         .doc(userCredential.user!.uid)
//         .set({
//       'name': userCredential.user?.displayName ?? '',
//       'uid': userCredential.user?.uid,
//       'email': userCredential.user?.email,
//       'provider': 'facebook',
//     });

//     return userCredential;
//   }

//   // Tạo hoặc cập nhật tài liệu người dùng trong Firestore
//   Future<void> createUser({User? user, required BuildContext context}) async {
//     // Nếu user đã tồn tại, chỉ cập nhật trường 'name'
//     // Nếu không, tạo mới tài liệu user
//     DocumentSnapshot userDoc = await _firestore.collection("users").doc(user?.uid).get();
//     if (userDoc.exists) {
//       await _firestore.collection("users").doc(user?.uid).update({
//         'name': user?.displayName ?? userDoc.get('name'),
//       });
//     } else {
//       await _firestore.collection("users").doc(user?.uid).set({
//         'name': user?.displayName ?? '',
//         'uid': user?.uid,
//         'email': user?.email,
//         'provider': user?.providerData.first.providerId,
//       });
//     }

//     // Chuyển hướng đến MainScreen
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (_) => const MainScreen(),
//         ),
//         (route) => false);
//   }

//   // sign out
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Check if the user is logged in or not
//   bool isSignedIn() {
//     return _auth.currentUser != null;
//   }

//   // Returns the current user
//   User? getCurrentUser() {
//     return _auth.currentUser;
//   }

//   // deleteAccount
//   Future<void> deleteAccount(String email) async {
//     try {
//       // Lấy user hiện tại từ Firebase Auth
//       User? user = _auth.currentUser;

//       // Nếu user chưa đăng nhập, không thể xóa tài khoản
//       if (user == null) {
//         print("User is not logged in.");
//         return;
//       }

//       // Xóa tài khoản trong Firebase Auth
//       await user.delete();

//       // Xóa dữ liệu trong Firestore (collection "users")
//       await _firestore.collection("users").doc(user.uid).delete();

//       // Xóa toàn bộ collection "users"
//       // await _firestore.collection("users").get().then((QuerySnapshot snapshot) {
//       //   for (DocumentSnapshot doc in snapshot.docs) {
//       //     doc.reference.delete();
//       //   }
//       // });

//       print("Account deleted successfully.");
//     } catch (e) {
//       print("Error deleting account: $e");
//     }
//   }

//   updatePassword(String email, String text, String text2, String text3) {}
}
