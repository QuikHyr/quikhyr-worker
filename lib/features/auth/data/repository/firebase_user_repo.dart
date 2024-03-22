import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
import 'package:http/http.dart' as http;
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
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: workerModel.email, password: password);

      WorkerModel newUser = workerModel.copyWith(
        id: userCredential.user!.uid,
      );

      await setUserData(newUser);

      return newUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> setUserData(WorkerModel workerModel) async {
    try {
      final result = await createWorker(workerModel);
      result.fold(
        (failure) {
          log('Failed to create worker: $failure');
          throw Exception(failure);
        },
        (worker) {
          log('Successfully created worker: ${worker.id}');
          log('Successfully created worker: $workerModel');
        },
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Either<String, WorkerModel>> createWorker(WorkerModel worker) async {
    log(baseUrl);
    final url = Uri.parse('$baseUrl/workers');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: worker.toJson(),
    );

    if (response.statusCode == 201) {
      return Right(WorkerModel.fromJson(response.body));
    } else {
      log(response.body);
      return Left('Failed to create worker ${response.body}');
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
