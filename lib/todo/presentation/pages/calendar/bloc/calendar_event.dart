part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  @override
  final List<dynamic> props;

  const CalendarEvent([this.props = const <dynamic>[]]);
}

class InitialEvent extends CalendarEvent {
  final CategoryEntity? category;

  InitialEvent(this.category) : super([category]);
}

class DateSelected extends CalendarEvent {
  final DateTime dateTime;

  DateSelected(this.dateTime) : super([dateTime]);
}

class DeleteTodoEvent extends CalendarEvent {
  final TodoEntity todo;

  DeleteTodoEvent(this.todo) : super([todo]);
}

class CompleteTodoEvent extends CalendarEvent {
  final TodoEntity todo;

  CompleteTodoEvent(this.todo) : super([todo]);
}

class TodoClickEvent extends CalendarEvent {
  final TodoEntity todo;

  TodoClickEvent(this.todo) : super([todo]);
}
