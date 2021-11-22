

import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  final auth = FirebaseAuth.instance;

  Future<dynamic> signUp (String password ,String email) async {
   var authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
   return authResult;
  }

  Future<dynamic> signIn (String password ,String email) async {
    var authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }


}