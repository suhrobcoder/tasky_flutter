import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasky/core/theme/app_theme.dart';

class TodoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool done;
  final DateTime date;
  final Function onClick;
  final Function onClickDelete;
  final Function onClickComplete;
  const TodoItem(
      {required this.title,
      required this.subtitle,
      required this.done,
      required this.date,
      required this.onClick,
      required this.onClickDelete,
      required this.onClickComplete,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const SizedBox(),
        extentRatio: 0.25,
        children: [
          TodoAction(
            caption: "Delete",
            icon: Icons.delete,
            color: Colors.redAccent,
            onClick: () => onClickDelete(),
          ),
          TodoAction(
            caption: "Complete",
            icon: Icons.done,
            color: Colors.blueAccent,
            onClick: () => onClickComplete(),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
            borderRadius: BorderRadius.circular(10),
            onTap: () => onClick(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Row(
                children: [
                  Image.asset(
                    getIconPathForTodoStatus(),
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20)),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 16,
                          color: subtitleTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getIconPathForTodoStatus() {
    if (done) {
      return "assets/images/done.png";
    }
    if (date.millisecondsSinceEpoch > DateTime.now().millisecondsSinceEpoch) {
      return "assets/images/pending.png";
    }
    return "assets/images/postponed.png";
  }
}

class TodoAction extends StatelessWidget {
  final String caption;
  final IconData icon;
  final Color color;
  final Function onClick;
  const TodoAction({
    required this.caption,
    required this.icon,
    required this.color,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: SlidableAction(
        borderRadius: BorderRadius.circular(10),
        icon: icon,
        backgroundColor: color,
        onPressed: (context) => onClick(),
      ),
    );
  }
}
