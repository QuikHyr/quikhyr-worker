part of 'service_and_subservice_list_bloc.dart';

@immutable
sealed class ServiceAndSubserviceListState {}

final class ServiceAndSubserviceListInitial extends ServiceAndSubserviceListState {}

sealed class ServiceListState extends ServiceAndSubserviceListState {}

final class ServiceListLoading extends ServiceListState {}

final class ServiceListLoaded extends ServiceListState {
  final List<ServiceModel> serviceModel;
  ServiceListLoaded({required this.serviceModel});
}

final class ServiceListError extends ServiceListState {
  final String error;
  ServiceListError({required this.error});
}

sealed class SubserviceListState extends ServiceAndSubserviceListState {}

final class SubserviceListLoading extends SubserviceListState {}

final class SubserviceListLoaded extends SubserviceListState {
  final List<SubserviceModel> subserviceModel;
  SubserviceListLoaded({required this.subserviceModel});
}

final class SubserviceListError extends SubserviceListState {
  final String error;
  SubserviceListError({required this.error});
}