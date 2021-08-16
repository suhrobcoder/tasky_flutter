import 'package:flutter/material.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';

class NewCategoryDialog extends StatefulWidget {
  final Function onCancelClick;
  final Function(CategoryEntity) onOkClick;
  const NewCategoryDialog(
      {required this.onCancelClick, required this.onOkClick, Key? key})
      : super(key: key);

  @override
  _NewCategoryDialogState createState() => _NewCategoryDialogState();
}

class _NewCategoryDialogState extends State<NewCategoryDialog> {
  final TextEditingController textController = TextEditingController();

  var selectedColor = colors[0];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("New Category"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              labelText: "Title",
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: colors
                .map(
                  (color) => GestureDetector(
                    onTap: () => setState(() {
                      selectedColor = color;
                    }),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: selectedColor == color
                          ? const Icon(Icons.check, color: Colors.white)
                          : null,
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => widget.onCancelClick(),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
        TextButton(
          onPressed: () => widget.onOkClick(
            CategoryEntity.withColor(
              name: textController.text,
              color: selectedColor,
            ),
          ),
          child: const Text("OK"),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}

final colors = <Color>[
  Colors.redAccent,
  Colors.blueAccent,
  Colors.green,
  Colors.yellowAccent,
  Colors.orangeAccent,
  Colors.cyanAccent,
  Colors.purpleAccent,
  Colors.pinkAccent
];
