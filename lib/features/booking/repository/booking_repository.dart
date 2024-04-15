import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/models/booking_model.dart';

class BookingRepository {
  Future<Either<String, bool>> createBooking(BookingModel booking) async {
  final url = Uri.parse('$baseUrl/bookings');

  try {
      print(booking.toJson());
    final response = await http.post(
      url,
      body: jsonEncode(booking.toJson()),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // final responseData = jsonDecode(response.body);
      return right(true);
    } else {
    return Left('Failed to create notification ${response.body}');
    }
  } catch (e) {
    return Left('Failed to create notification $e');
  }
}
}
