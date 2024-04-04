import 'dart:async';

import 'package:bloc/bloc.dart';
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
    on<GetSubserviceList>(_getSubserviceList);
  }

  // FutureOr<void> _getServiceList(GetServiceList event, Emitter<ServiceAndSubserviceListState> emit) async{
  //   emit(ServiceListLoading());
  //   final response = await dataProvider.getServicesData();
  //   response.fold(
  //     (l) => emit(ServiceListError(error: l)),
  //     (r) => emit(ServiceListLoaded(serviceModel: r)),
  //   );
  // }

  FutureOr<void> _getSubserviceList(GetSubserviceList event, Emitter<ServiceAndSubserviceListState> emit) async{
    emit(SubserviceListLoading());
    final response = await dataProvider.getSubservices();
    response.fold(
      (l) => emit(SubserviceListError(error: l)),
      (r) => emit(SubserviceListLoaded(subserviceModel: r)),
    );
  }
}
