import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<User> get onAuthStateChanged => _auth.authStateChanges();

  Future<User> get user async => _auth.currentUser;

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> signInWithPhoneNumber(code, _verificationId) async {
    await _auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: code,
      ),
    );
  }

  Future<void> verifyPhoneNumber({
    String phoneNumber,
    void Function(String) verificationFailed,
    void Function(String) codeAutoRetrievalTimeout,
    void Function(String, [int]) codeSent,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationFailed: (FirebaseAuthException e) =>
          verificationFailed(e.message),
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) =>
          _auth.signInWithCredential(phoneAuthCredential),
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      codeSent: codeSent,
    );
  }
}
