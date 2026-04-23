import 'package:first_flutter_project/utils/app_extensions.dart';
import 'package:first_flutter_project/utils/enums.dart';
import 'package:flutter/material.dart';

class TaskStatusWidget extends StatelessWidget {
  final TaskStatus taskStatus;
  final Function(TaskStatus taskStatus) onChanged;

  final bool isSelected;

  const TaskStatusWidget({
    super.key,
    required this.taskStatus,
    required this.onChanged,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(taskStatus);
      },
      borderRadius: BorderRadius.all(Radius.circular(24)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        child: Text(
          taskStatus.name.capitalize(),
          style: TextStyle(
            fontWeight: .w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
