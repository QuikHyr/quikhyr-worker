import 'package:dartz/dartz.dart';
import 'package:quikhyr_worker/features/auth/data/data_provider/service_and_subservices_data_provider.dart';
import 'package:quikhyr_worker/models/service_model.dart';
import 'package:quikhyr_worker/models/subservices_model.dart';
import 'dart:convert';


class ServiceAndSubserviceRepo {
  final ServiceAndSubservicesDataProvider dataProvider;

  ServiceAndSubserviceRepo({required this.dataProvider});

Future<Either<String, List<ServiceModel>>> getServicesData() async {
  try {
    final response = await dataProvider.getServicesData();
    final jsonResponse = jsonDecode(response);
    if (jsonResponse is! List<dynamic>) {
      throw Exception('Unexpected response format');
    }
    final serviceModelList = jsonResponse.map((item) => ServiceModel.fromJson(json.encode(item))).toList();
    return Right(serviceModelList);
  } catch (e) {
    return Left(e.toString());
  }
}

  Future<Either<String, List<SubserviceModel>>> getSubservices() async {
    try {
      final response = await dataProvider.getSubservicesData();
      final jsonResponse = jsonDecode(response);
     if (jsonResponse is! List<dynamic>) {
      throw Exception('Unexpected response format');
    }
    final subserviceModelList = jsonResponse.map((item) => SubserviceModel.fromJson(json.encode(item))).toList();
      return Right(subserviceModelList);
    } catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, Tuple2<List<ServiceModel>, List<SubserviceModel>>>> getServicesAndSubservicesData() async {
  try {
    final servicesResponse = await getServicesData();
    final subservicesResponse = await getSubservices();
    return servicesResponse.flatMap((services) => subservicesResponse.map((subservices) => Tuple2(services, subservices)));
  } catch (e) {
    return Left(e.toString());
  }
}

}