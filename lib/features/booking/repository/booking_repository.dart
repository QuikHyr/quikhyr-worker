import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quikhyr_worker/common/quik_secure_constants.dart';
import 'package:quikhyr_worker/models/booking_model.dart';
import 'package:quikhyr_worker/models/simple_booking_model.dart';

class BookingRepository {
  Future<Either<String, bool>> createBooking(SimpleBookingModel booking) async {
    final url = Uri.parse('$baseUrl/bookings');

    try {
      debugPrint(booking.toJson());
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

  Future<Either<String, BookingData>> getBookingsById(String workerId) async {
    final url = Uri.parse('$baseUrl/bookings/?workerId=$workerId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        debugPrint(response.body);
        final bookingData = jsonDecode(response.body);
        debugPrint(bookingData.toString());
        return Right(BookingData.fromJson(bookingData));
      } else {
        return Left('Failed to get booking data ${response.body}');
      }
    } catch (e) {
      return Left('Failed to get booking data $e');
    }
  }
}
