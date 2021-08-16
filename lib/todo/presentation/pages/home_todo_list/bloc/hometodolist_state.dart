part of 'hometodolist_bloc.dart';

abstract class HomeTodoListState extends Equatable {
  final List<CategoryEntity> categories;
  final List<TodoEntity> todos;

  const HomeTodoListState({required this.categories, required this.todos});

  InitialState getInitialState({
    List<CategoryEntity>? newCategories,
    List<TodoEntity>? newTodos,
  }) {
    return InitialState(
      categories: newCategories ?? categories,
      todos: newTodos ?? todos,
    );
  }

  ErrorState getErrorState(String message) {
    return ErrorState(message, categories: categories, todos: todos);
  }

  ShowNewCategoryDialogState getShowNewCategoryDialogState() {
    return ShowNewCategoryDialogState(categories: categories, todos: todos);
  }

  ShowTodoDialogState getShowTodoDialogState(TodoEntity todo) {
    return ShowTodoDialogState(todo, categories: categories, todos: todos);
  }

  HomeTodoListState copyWith({
    List<CategoryEntity>? categories,
    List<TodoEntity>? todos,
  }) {
    return InitialState(
      categories: categories ?? this.categories,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object?> get props => [categories, todos];
}

class InitialState extends HomeTodoListState {
  const InitialState({
    required List<CategoryEntity> categories,
    required List<TodoEntity> todos,
  }) : super(categories: categories, todos: todos);
}

class ErrorState extends HomeTodoListState {
  final String message;

  const ErrorState(
    this.message, {
    required List<CategoryEntity> categories,
    required List<TodoEntity> todos,
  }) : super(categories: categories, todos: todos);

  @override
  List<Object?> get props => [categories, todos, message];
}

class ShowNewCategoryDialogState extends HomeTodoListState {
  const ShowNewCategoryDialogState({
    required List<CategoryEntity> categories,
    required List<TodoEntity> todos,
  }) : super(categories: categories, todos: todos);
}

class ShowTodoDialogState extends HomeTodoListState {
  final TodoEntity todo;

  const ShowTodoDialogState(
    this.todo, {
    required List<CategoryEntity> categories,
    required List<TodoEntity> todos,
  }) : super(categories: categories, todos: todos);

  @override
  List<Object?> get props => [categories, todos, todo];
}
