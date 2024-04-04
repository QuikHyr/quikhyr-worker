import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:quikhyr_worker/features/auth/data/repository/service_and_subservice_repo.dart';
import 'package:quikhyr_worker/models/service_model.dart';
import 'package:quikhyr_worker/models/subservices_model.dart';

part 'service_and_subservice_list_event.dart';
part 'service_and_subservice_list_state.dart';

class ServiceAndSubserviceListBloc
    extends Bloc<ServiceAndSubserviceListEvent, ServiceAndSubserviceListState> {
      final ServiceAndSubserviceRepo dataProvider;
  ServiceAndSubserviceListBloc(this.dataProvider) : super(ServiceAndSubserviceListInitial()) {
    // on<GetServiceList>(_getServiceList);
    on<GetServicesAndSubservices>(_getServicesAndSubservices);
  }

  // FutureOr<void> _getServiceList(GetServiceList event, Emitter<ServiceAndSubserviceListState> emit) async{
  //   emit(ServiceListLoading());
  //   final response = await dataProvider.getServicesData();
  //   response.fold(
  //     (l) => emit(ServiceListError(error: l)),
  //     (r) => emit(ServiceListLoaded(serviceModel: r)),
  //   );
  // }

  // FutureOr<void> _getSubserviceList(GetSubserviceList event, Emitter<ServiceAndSubserviceListState> emit) async{
  //   emit(SubserviceListLoading());
  //   final response = await dataProvider.getSubservices();
  //   response.fold(
  //     (l) => emit(SubserviceListError(error: l)),
  //     (r) => emit(SubserviceListLoaded(subserviceModel: r)),
  //   );
  // }



  FutureOr<void> _getServicesAndSubservices(GetServicesAndSubservices event, Emitter<ServiceAndSubserviceListState> emit) async{
    emit(ServiceAndSubserviceListLoading());
    final response = await dataProvider.getServicesAndSubservicesData();

    response.fold(
      (l) => emit(ServiceAndSubserviceListError(error: l)),
      (r) {
      emit(ServiceAndSubserviceListLoaded(serviceModels: r.value1, subserviceModels: r.value2));
      debugPrint('Success response: $r');
      },
    );
  }
}
