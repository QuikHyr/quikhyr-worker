import 'package:dartz/dartz.dart';
import 'package:quikhyr_worker/features/auth/data/data_provider/service_and_subservices_data_provider.dart';
import 'package:quikhyr_worker/models/service_model.dart';
import 'package:quikhyr_worker/models/subservices_model.dart';

class ServiceAndSubserviceRepo {
  final ServiceAndSubservicesDataProvider dataProvider;

  ServiceAndSubserviceRepo({required this.dataProvider});

  Future<Either<String, ServiceModel>> getServicesData() async {
    try {
      final response = await dataProvider.getServicesData();
      final serviceModel = ServiceModel.fromJson(response);
      return Right(serviceModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SubserviceModel>> getSubservicesByServiceIdData(String serviceId) async {
    try {
      final response = await dataProvider.getSubservicesByServiceIdData(serviceId);
      final subserviceModel = SubserviceModel.fromJson(response);
      return Right(subserviceModel);
    } catch (e) {
      return Left(e.toString());
    }
  }
}