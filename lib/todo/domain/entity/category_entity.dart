import 'package:flutter/material.dart';
import 'package:tasky/core/extensions/hex_color.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String color;
  final int allTasks;
  final int doneTasks;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.color,
    this.allTasks = 0,
    this.doneTasks = 0,
  });

  CategoryEntity.withColor({
    required this.id,
    required this.name,
    required Color color,
  })  : color = color.toHex(),
        allTasks = 0,
        doneTasks = 0;

  Color getColor() {
    return HexColor.fromHex(color);
  }
}
