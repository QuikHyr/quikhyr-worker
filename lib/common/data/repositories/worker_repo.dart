import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/models/worker_model.dart';
import 'package:http/http.dart' as http;

class WorkerRepo {
  Future<Either<String, WorkerModel>> getWorker(
      {required String workerId}) async {
    final url = Uri.parse('$baseUrl/workers/$workerId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Right(WorkerModel.fromJson(response.body));
    } else {
      return Left('Failed to get worker ${response.body}');
    }
  }


  Future<Either<String, bool>> isUserCreatedInFirestore(String userId) async {
    try {
      final url = Uri.parse('$baseUrl/workers/$userId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return const Right(true);
      } else if (response.statusCode == 404) {
        return const Right(false);
      } else {
        return const Left('Failed to check user existence in Firestore');
      }
    } catch (e) {
      return Left('Failed to check user existence in Firestore: $e');
    }
  }


  Future<Either<String, String>> updateWorkerPincode(
      {required String workerId, required String pincode}) async {
    try {
      final url = Uri.parse('$baseUrl/workers/$workerId');
      final body = jsonEncode({"pincode": pincode});
      final response = await http
          .put(url, body: body, headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        return const Right('Worker pincode updated');
      } else {
        return Left('Failed to update worker pincode ${response.body}');
      }
    } catch (e) {
      return Left('Failed to update worker pincode: $e');
    }
  }
}
