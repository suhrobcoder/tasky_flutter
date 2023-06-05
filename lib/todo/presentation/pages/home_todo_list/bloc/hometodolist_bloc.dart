import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/add_category.dart';
import 'package:tasky/todo/domain/usecase/complete_todo.dart';
import 'package:tasky/todo/domain/usecase/delete_todo.dart';
import 'package:tasky/todo/domain/usecase/get_categories.dart';
import 'package:tasky/todo/domain/usecase/get_todos_for_today.dart';

part 'hometodolist_event.dart';
part 'hometodolist_state.dart';

@injectable
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
    on<_CategoriesEvent>((event, emit) {
      emit(state.copyWith(categories: event.categories));
    });
    on<_TodosEvent>((event, emit) {
      emit(state.copyWith(todos: event.todos));
    });
    on<NewCategoryClickEvent>((event, emit) {
      emit(state.getShowNewCategoryDialogState());
      emit(state.getInitialState());
    });
    on<AddCategoryEvent>((event, emit) async {
      try {
        await addCategory.execute(event.category);
      } catch (error) {
        emit(state.getErrorState("Error"));
      }
    });
    on<TodoClickEvent>((event, emit) {
      emit(state.getShowTodoDialogState(event.todo));
      emit(state.getInitialState());
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
    getCategories.execute().listen((categories) {
      add(_CategoriesEvent(categories));
    });
    getTodos.execute().listen((todos) {
      add(_TodosEvent(todos));
    });
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
