import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_theme.dart';
import 'package:tasky/global_widgets/buttons.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';

class TodoDialog extends StatelessWidget {
  final TodoEntity todo;
  final Function onComplete;
  const TodoDialog({required this.todo, required this.onComplete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            todo.title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.description),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  todo.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.date_range),
              const SizedBox(width: 8),
              Text(
                todo.date.toString(),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.tag),
              const SizedBox(width: 8),
              Text(
                todo.category,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PrimaryButton("Complete", primaryColor, () => onComplete()),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
