import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial(0)) {
    on<PageSelectEvent>((event, emit) {
      if (state.pageIndex != event.index) {
        emit(HomeInitial(event.index));
      }
    });
    on<CategorySelectEvent>((event, emit) {
      emit(HomeInitial(1, category: event.category));
    });
  }
}
