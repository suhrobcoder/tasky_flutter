import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/complete_todo.dart';
import 'package:tasky/todo/domain/usecase/delete_todo.dart';
import 'package:tasky/todo/domain/usecase/get_category.dart';
import 'package:tasky/todo/domain/usecase/get_todos_by_category.dart';
import 'package:tasky/core/extensions/datetime_ext.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetTodosByCategory getTodosByCategory;
  final GetCategory getCategory;
  final DeleteTodo deleteTodo;
  final CompleteTodo completeTodo;

  CalendarBloc(this.getTodosByCategory, this.getCategory, this.deleteTodo, this.completeTodo)
      : super(InitialState(selectedDate: DateTime.now(), todos: const []));

  StreamSubscription<CategoryEntity>? categorySubScription;
  StreamSubscription<List<TodoEntity>>? todosSubScription;

  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {
    if (event is InitialEvent) {
      await categorySubScription?.cancel();
      await todosSubScription?.cancel();
      if (event.category != null) {
        categorySubScription = getCategory.execute(event.category!.name).listen(
          (category) {
            add(_CategoryEvent(category));
          },
        );
      } else {
        yield state.copyWith(category: null);
      }
      todosSubScription = getTodosByCategory.execute(event.category).listen((todos) {
        add(_TodosEvent(todos));
      });
    } else if (event is DateSelected) {
      yield state.copyWith(selectedDate: event.dateTime);
    } else if (event is DeleteTodoEvent) {
      try {
        await deleteTodo.execute(event.todo);
      } catch (error) {
        yield state.getErrorState("Error");
      }
    } else if (event is CompleteTodoEvent) {
      try {
        await completeTodo.execute(event.todo);
      } catch (error) {
        yield state.getErrorState("Error");
      }
    } else if (event is TodoClickEvent) {
      yield state.getShowTodoDialogState(event.todo);
    } else if (event is _CategoryEvent) {
      yield state.copyWith(category: event.category);
    } else if (event is _TodosEvent) {
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
      yield state.copyWith(todos: todosByDate);
    }
  }

  @override
  Stream<Transition<CalendarEvent, CalendarState>> transformEvents(
      Stream<CalendarEvent> events, TransitionFunction<CalendarEvent, CalendarState> transitionFn) {
    events.listen((event) {
      print("Event: " + event.toString());
    });
    return super.transformEvents(events, transitionFn);
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
