import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/add_todo.dart';
import 'package:tasky/todo/domain/usecase/get_categories.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final GetCategories getCategories;
  final AddTodo addTodo;

  AddTodoBloc(this.getCategories, this.addTodo)
      : super(InitialState(
          todo: TodoEntity(
              id: 0,
              title: "",
              description: "",
              category: "",
              date: DateTime.now(),
              notification: false,
              priorityHigh: false,
              done: false),
          categories: [],
        )) {
    getCategories.execute().listen((categories) {
      add(_CategoriesEvent(categories));
    });
  }

  @override
  Stream<AddTodoState> mapEventToState(
    AddTodoEvent event,
  ) async* {
    if (event is CategoryChanged) {
      yield state.copyWith(todo: state.todo.copyWith(category: event.category));
    } else if (event is DateChangeEvent) {
      yield state.copyWith(todo: state.todo.copyWith(date: event.date));
    } else if (event is NotificationChanged) {
      yield state.copyWith(todo: state.todo.copyWith(notification: event.notification));
    } else if (event is DateTimeClickEvent) {
      yield state.getDateTimeDialogState();
      yield state.copyWith();
    } else if (event is AddTodoClickEvent) {
      if (event.title.isEmpty) {
        yield state.getErrorState("Title cannot be empty");
      } else {
        var todo = state.todo.copyWith(title: event.title, description: event.description);
        try {
          await addTodo.execute(todo);
          yield state.getNavigateBackState();
        } catch (error) {
          yield state.getErrorState("$error");
        }
      }
    } else if (event is _CategoriesEvent) {
      yield state.copyWith(
          todo: state.todo.copyWith(category: event.categories[0].name),
          categories: event.categories);
    }
  }
}

class _CategoriesEvent extends AddTodoEvent {
  final List<CategoryEntity> categories;

  _CategoriesEvent(this.categories);
}
