part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent([this.props = const []]);

  @override
  final List<Object> props;
}

class CategoryChanged extends AddTodoEvent {
  final String category;

  CategoryChanged(this.category) : super([category]);
}

class DateChangeEvent extends AddTodoEvent {
  final DateTime date;

  DateChangeEvent(this.date) : super([date]);
}

class NotificationChanged extends AddTodoEvent {
  final bool notification;

  NotificationChanged(this.notification) : super([notification]);
}

class DateTimeClickEvent extends AddTodoEvent {}

class AddTodoClickEvent extends AddTodoEvent {
  final String title;
  final String description;

  AddTodoClickEvent(this.title, this.description) : super([title, description]);
}
