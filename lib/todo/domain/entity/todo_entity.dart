class TodoEntity {
  final int id;
  final String title;
  final String description;
  final String category;
  final DateTime date;
  final bool notification;
  final bool priorityHigh;
  final bool done;

  TodoEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.notification,
    required this.priorityHigh,
    required this.done,
  });

  TodoEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? date,
    bool? notification,
    bool? priorityHigh,
    bool? done,
  }) {
    return TodoEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        date: date ?? this.date,
        notification: notification ?? this.notification,
        priorityHigh: priorityHigh ?? this.priorityHigh,
        done: done ?? this.done);
  }
}
