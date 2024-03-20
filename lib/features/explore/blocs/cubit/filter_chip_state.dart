part of 'filter_chip_cubit.dart';

sealed class FilterChipState extends Equatable {
  const FilterChipState();

  @override
  List<Object> get props => [];
}

final class AllState extends FilterChipState {}

final class HighRatedState extends FilterChipState {}

final class LowBudgetState extends FilterChipState {}

final class MostPopularState extends FilterChipState {}
