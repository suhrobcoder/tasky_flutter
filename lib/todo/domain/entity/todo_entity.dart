class TodoEntity {
  final int id;
  final String title;
  final String description;
  final String categoryId;
  final String date;
  final bool notification;
  final bool priorityHigh;
  final bool done;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.categoryId,
    required this.date,
    required this.notification,
    required this.priorityHigh,
    required this.done,
  });
}
