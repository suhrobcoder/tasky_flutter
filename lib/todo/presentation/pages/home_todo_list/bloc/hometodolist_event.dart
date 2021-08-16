part of 'hometodolist_bloc.dart';

abstract class HomeTodoListEvent extends Equatable {
  @override
  final List<dynamic> props;

  const HomeTodoListEvent([this.props = const <dynamic>[]]);
}

class NewCategoryClickEvent extends HomeTodoListEvent {}

class AddCategoryEvent extends HomeTodoListEvent {
  final CategoryEntity category;

  AddCategoryEvent(this.category) : super([category]);
}

class TodoClickEvent extends HomeTodoListEvent {
  final TodoEntity todo;

  TodoClickEvent(this.todo) : super([todo]);
}

class DeleteTodoEvent extends HomeTodoListEvent {
  final TodoEntity todo;

  DeleteTodoEvent(this.todo) : super([todo]);
}

class CompleteTodoEvent extends HomeTodoListEvent {
  final TodoEntity todo;

  CompleteTodoEvent(this.todo) : super([todo]);
}
