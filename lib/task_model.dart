import 'package:first_flutter_project/enums.dart';

class TaskModel {
  final String title;
  final String description;
  final TaskCategory category;
  final TaskStatus taskStatus;

  const TaskModel({
    required this.title,
    required this.description,
    required this.category,
    required this.taskStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "category": category.name,
      "taskStatus": taskStatus.name,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json["title"],
      description: json["description"],
      category: TaskCategory.values.firstWhere(
        (e) => e.name == json["category"],
      ),
      taskStatus: TaskStatus.values.firstWhere(
        (e) => e.name == json["taskStatus"],
      ),
    );
  }
}
