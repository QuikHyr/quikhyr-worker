part of 'service_and_subservice_list_bloc.dart';

@immutable
sealed class ServiceAndSubserviceListState {}

final class ServiceAndSubserviceListInitial extends ServiceAndSubserviceListState {}

final class ServiceAndSubserviceListLoading extends ServiceAndSubserviceListState {}

final class ServiceAndSubserviceListLoaded extends ServiceAndSubserviceListState {
  final List<ServiceModel> serviceModels;
  final List<SubserviceModel> subserviceModels;
  ServiceAndSubserviceListLoaded({required this.serviceModels, required this.subserviceModels});
}

final class ServiceAndSubserviceListError extends ServiceAndSubserviceListState {
  final String error;
  ServiceAndSubserviceListError({required this.error});
}

// sealed class ServiceListState extends ServiceAndSubserviceListState {}

// final class ServiceListLoading extends ServiceListState {}

// final class ServiceListLoaded extends ServiceListState {
//   final List<ServiceModel> serviceModel;
//   ServiceListLoaded({required this.serviceModel});
// }

// final class ServiceListError extends ServiceListState {
//   final String error;
//   ServiceListError({required this.error});
// }

// sealed class SubserviceListState extends ServiceAndSubserviceListState {}

// final class SubserviceListLoading extends SubserviceListState {}

// final class SubserviceListLoaded extends SubserviceListState {
//   final List<SubserviceModel> subserviceModels;
//   SubserviceListLoaded({required this.subserviceModels});
// }

// final class SubserviceListError extends SubserviceListState {
//   final String error;
//   SubserviceListError({required this.error});
// }