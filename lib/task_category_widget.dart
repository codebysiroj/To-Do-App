import 'package:first_flutter_project/app_extensions.dart';
import 'package:first_flutter_project/enums.dart';
import 'package:flutter/material.dart';

class TaskCategoryWidget extends StatelessWidget {
  final TaskCategory taskCategory;

  const TaskCategoryWidget({super.key, required this.taskCategory});

  Color titleColor() {
    switch (taskCategory) {
      case TaskCategory.work:
        return Colors.blue;
      case TaskCategory.personal:
        return Colors.purple;
      case TaskCategory.study:
        return Colors.green;
    }
  }

  Color backgroundColor() {
    switch (taskCategory) {
      case TaskCategory.work:
        return Colors.blue.withOpacity(0.15);
      case TaskCategory.personal:
        return Colors.purple.withOpacity(0.15);
      case TaskCategory.study:
        return Colors.green.withOpacity(0.15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: backgroundColor(),
      ),
      child: Text(
        taskCategory.name.capitalize(),
        style: TextStyle(fontSize: 12, color: titleColor()),
      ),
    );
  }
}
