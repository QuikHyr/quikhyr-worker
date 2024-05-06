part of 'service_and_subservice_list_bloc.dart';

@immutable
sealed class ServiceAndSubserviceListEvent {}

// final class GetServiceList extends ServiceAndSubserviceListEvent {}

final class GetServicesAndSubservices extends ServiceAndSubserviceListEvent {
  GetServicesAndSubservices();
}



// final class GetServiceAndSubserviceList extends ServiceAndSubserviceListEvent {
//   final String serviceId;
//   GetServiceAndSubserviceList({required this.serviceId});
// }

// final class GetSubserviceListByServiceId extends ServiceAndSubserviceListEvent {
//   final String serviceId;
//   GetSubserviceListByServiceId({required this.serviceId});
// }

// final class GetServiceAndSubserviceListByServiceId extends ServiceAndSubserviceListEvent {
//   final String serviceId;
//   GetServiceAndSubserviceListByServiceId({required this.serviceId});
// }


