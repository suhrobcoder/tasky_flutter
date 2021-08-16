import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_theme.dart';

import 'progress_widget.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final Color color;
  final int allTasks;
  final int doneTasks;
  final Function onClick;
  const CategoryCard(
      {required this.name,
      required this.color,
      required this.allTasks,
      required this.doneTasks,
      required this.onClick,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      margin: const EdgeInsets.only(bottom: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: const Offset(2, 4),
            blurRadius: 10,
            color: Colors.black54.withOpacity(0.12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 18, color: subtitleTextColor),
              ),
              const SizedBox(height: 8),
              ProgressWidget(
                  color: color,
                  progress: allTasks == 0 ? 0 : doneTasks / allTasks),
              const SizedBox(height: 8),
              Text(
                "$doneTasks/$allTasks",
                style: const TextStyle(fontSize: 16, color: subtitleTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
