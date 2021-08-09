import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial(0));

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    print(event.toString());
    if (event is PageSelectEvent) {
      if (state.pageIndex != event.index) {
        yield HomeInitial(event.index);
      }
    } else if (event is CategorySelectEvent) {
      yield HomeInitial(1, category: event.category);
    }
  }
}
