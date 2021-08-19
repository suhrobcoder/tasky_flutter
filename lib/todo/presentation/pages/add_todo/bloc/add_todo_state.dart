part of 'add_todo_bloc.dart';

abstract class AddTodoState extends Equatable {
  @override
  final List<Object> props;

  final TodoEntity todo;
  final List<CategoryEntity> categories;

  const AddTodoState({required this.todo, required this.categories, this.props = const []});

  DateTimeDialogState getDateTimeDialogState() {
    return DateTimeDialogState(todo: todo, categories: categories);
  }

  NavigateBackState getNavigateBackState() {
    return NavigateBackState(todo: todo, categories: categories);
  }

  ErrorState getErrorState(String message) {
    return ErrorState(message, todo: todo, categories: categories);
  }

  AddTodoState copyWith({TodoEntity? todo, List<CategoryEntity>? categories}) {
    return InitialState(todo: todo ?? this.todo, categories: categories ?? this.categories);
  }
}

class InitialState extends AddTodoState {
  InitialState({required TodoEntity todo, required List<CategoryEntity> categories})
      : super(todo: todo, categories: categories, props: [todo]);
}

class DateTimeDialogState extends AddTodoState {
  DateTimeDialogState({required TodoEntity todo, required List<CategoryEntity> categories})
      : super(todo: todo, categories: categories, props: [todo]);
}

class NavigateBackState extends AddTodoState {
  NavigateBackState({required TodoEntity todo, required List<CategoryEntity> categories})
      : super(todo: todo, categories: categories, props: [todo]);
}

class ErrorState extends AddTodoState {
  final String message;
  ErrorState(this.message, {required TodoEntity todo, required List<CategoryEntity> categories})
      : super(todo: todo, categories: categories, props: [todo]);
}
