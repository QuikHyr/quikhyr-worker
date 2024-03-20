import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_chip_state.dart';

class FilterChipCubit extends Cubit<FilterChipState> {
  FilterChipCubit() : super(AllState());

  void selectAll() => emit(AllState());

  void selectHighRated() => emit(HighRatedState());

  void selectLowBudget() => emit(LowBudgetState()); 

  void selectMostPopular() => emit(MostPopularState());
}
