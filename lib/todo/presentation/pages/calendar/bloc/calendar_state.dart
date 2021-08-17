part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  final CategoryEntity? category;
  final DateTime selectedDate;
  final List<TodosByDate> todos;

  const CalendarState({required this.selectedDate, required this.todos, required this.category});

  @override
  List<Object?> get props => [category, selectedDate, todos];

  CalendarState copyWith(
      {CategoryEntity? category, DateTime? selectedDate, List<TodosByDate>? todos}) {
    return InitialState(
        category: category ?? this.category,
        selectedDate: selectedDate ?? this.selectedDate,
        todos: todos ?? this.todos);
  }

  ErrorState getErrorState(String message) {
    return ErrorState(message, category: category, selectedDate: selectedDate, todos: todos);
  }

  ShowTodoDialogState getShowTodoDialogState(TodoEntity todo) {
    return ShowTodoDialogState(todo, category: category, selectedDate: selectedDate, todos: todos);
  }
}

class InitialState extends CalendarState {
  const InitialState({
    CategoryEntity? category,
    required DateTime selectedDate,
    required List<TodosByDate> todos,
  }) : super(category: category, selectedDate: selectedDate, todos: todos);
}

class ShowTodoDialogState extends CalendarState {
  final TodoEntity todo;

  const ShowTodoDialogState(
    this.todo, {
    CategoryEntity? category,
    required DateTime selectedDate,
    required List<TodosByDate> todos,
  }) : super(category: category, selectedDate: selectedDate, todos: todos);

  @override
  List<Object?> get props => [todo, category, selectedDate, todos];
}

class ErrorState extends CalendarState {
  final String message;

  const ErrorState(
    this.message, {
    CategoryEntity? category,
    required DateTime selectedDate,
    required List<TodosByDate> todos,
  }) : super(category: category, selectedDate: selectedDate, todos: todos);

  @override
  List<Object?> get props => [message, category, selectedDate, todos];
}
