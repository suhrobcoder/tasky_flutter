import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/add_category.dart';
import 'package:tasky/todo/domain/usecase/complete_todo.dart';
import 'package:tasky/todo/domain/usecase/delete_todo.dart';
import 'package:tasky/todo/domain/usecase/get_categories.dart';
import 'package:tasky/todo/domain/usecase/get_todos_for_today.dart';

part 'hometodolist_event.dart';
part 'hometodolist_state.dart';

class HomeTodoListBloc extends Bloc<HomeTodoListEvent, HomeTodoListState> {
  final GetCategories getCategories;
  final GetTodosForToday getTodos;
  final AddCategory addCategory;
  final DeleteTodo deleteTodo;
  final CompleteTodo completeTodo;

  HomeTodoListBloc(
    this.getCategories,
    this.getTodos,
    this.addCategory,
    this.deleteTodo,
    this.completeTodo,
  ) : super(const InitialState(categories: [], todos: [])) {
    getCategories.execute().listen((categories) {
      add(_CategoriesEvent(categories));
    });
    getTodos.execute().listen((todos) {
      add(_TodosEvent(todos));
    });
  }

  @override
  Stream<HomeTodoListState> mapEventToState(
    HomeTodoListEvent event,
  ) async* {
    if (event is _CategoriesEvent) {
      yield state.copyWith(categories: event.categories);
    } else if (event is _TodosEvent) {
      yield state.copyWith(todos: event.todos);
    } else if (event is NewCategoryClickEvent) {
      yield state.getShowNewCategoryDialogState();
      yield state.getInitialState();
    } else if (event is AddCategoryEvent) {
      try {
        await addCategory.execute(event.category);
      } catch (error) {
        yield state.getErrorState("Error");
      }
    } else if (event is TodoClickEvent) {
      yield state.getShowTodoDialogState(event.todo);
      yield state.getInitialState();
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
    }
  }
}

class _CategoriesEvent extends HomeTodoListEvent {
  final List<CategoryEntity> categories;

  _CategoriesEvent(this.categories) : super([categories]);
}

class _TodosEvent extends HomeTodoListEvent {
  final List<TodoEntity> todos;

  _TodosEvent(this.todos) : super([todos]);
}
