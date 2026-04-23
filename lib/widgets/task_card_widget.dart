import 'package:first_flutter_project/utils/enums.dart';
import 'package:first_flutter_project/widgets/task_category_widget.dart';
import 'package:first_flutter_project/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;
  final Function() onRadioTap;
  final Function() onTap;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.onRadioTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.taskStatus == TaskStatus.completed;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: .start,
          children: [
            InkWell(
              onTap: onRadioTap,
              child: Container(
                height: 25,
                width: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted
                        ? Theme.of(context).primaryColor
                        : Colors.black26,
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? Icon(
                        Icons.check,
                        size: 14,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 16,
                      fontWeight: .bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TaskCategoryWidget(taskCategory: task.category),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
