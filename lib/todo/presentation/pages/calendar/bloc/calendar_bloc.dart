import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/complete_todo.dart';
import 'package:tasky/todo/domain/usecase/delete_todo.dart';
import 'package:tasky/todo/domain/usecase/get_category.dart';
import 'package:tasky/todo/domain/usecase/get_todos_by_category.dart';
import 'package:tasky/core/extensions/datetime_ext.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

@injectable
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetTodosByCategory getTodosByCategory;
  final GetCategory getCategory;
  final DeleteTodo deleteTodo;
  final CompleteTodo completeTodo;

  StreamSubscription<CategoryEntity>? categorySubScription;
  StreamSubscription<List<TodoEntity>>? todosSubScription;

  CalendarBloc(this.getTodosByCategory, this.getCategory, this.deleteTodo,
      this.completeTodo)
      : super(InitialState(selectedDate: DateTime.now(), todos: const [])) {
    on<InitialEvent>((event, emit) async {
      await categorySubScription?.cancel();
      await todosSubScription?.cancel();
      if (event.category != null) {
        categorySubScription = getCategory.execute(event.category!.name).listen(
          (category) {
            add(_CategoryEvent(category));
          },
        );
      } else {
        emit(state.copyWith(category: null));
      }
      todosSubScription =
          getTodosByCategory.execute(event.category).listen((todos) {
        add(_TodosEvent(todos));
      });
    });
    on<DateSelected>((event, emit) {
      emit(state.copyWith(selectedDate: event.dateTime));
    });
    on<DeleteTodoEvent>((event, emit) async {
      try {
        await deleteTodo.execute(event.todo);
      } catch (error) {
        emit(state.getErrorState("Error"));
      }
    });
    on<CompleteTodoEvent>((event, emit) async {
      try {
        await completeTodo.execute(event.todo);
      } catch (error) {
        emit(state.getErrorState("Error"));
      }
    });
    on<TodoClickEvent>((event, emit) {
      emit(state.getShowTodoDialogState(event.todo));
    });
    on<_CategoryEvent>((event, emit) {
      emit(state.copyWith(category: event.category));
    });
    on<_TodosEvent>((event, emit) {
      var latestDate = event.todos[0].date;
      var todosByDate = [TodosByDate(latestDate, [])];
      for (TodoEntity todo in event.todos) {
        if (latestDate.isSameDayWith(todo.date)) {
          todosByDate.last.todos.add(todo);
        } else {
          latestDate = todo.date.getStartOfDay();
          todosByDate.add(TodosByDate(latestDate, [todo]));
        }
      }
      emit(state.copyWith(todos: todosByDate));
    });
  }
}

class _CategoryEvent extends CalendarEvent {
  final CategoryEntity category;

  _CategoryEvent(this.category) : super([category]);
}

class _TodosEvent extends CalendarEvent {
  final List<TodoEntity> todos;

  _TodosEvent(this.todos) : super([todos]);
}

class TodosByDate {
  final DateTime dateTime;
  final List<TodoEntity> todos;

  TodosByDate(this.dateTime, this.todos);
}
