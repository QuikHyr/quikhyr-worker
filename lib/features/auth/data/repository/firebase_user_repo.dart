import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
// import 'package:quikhyr_worker/models/worker_model.dart';

class FirebaseUserRepo {
  final FirebaseAuth _firebaseAuth;
  // final usersCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<WorkerModel> signUp(WorkerModel workerModel, String password) async {
  try {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: workerModel.email, 
      password: password
    );

    WorkerModel newUser = workerModel.copyWith(
      id: userCredential.user!.uid,
    );

    return newUser;
  } catch (e) {
    log(e.toString());
    rethrow;
  }
}
  Future<void> setUserData(WorkerModel user) async {
    try {
      // await usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  // Future<void> setUserData(WorkerModel user) async {
  //   try {
  //     await usersCollection.doc(user.userId).set(user.toMap());
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
