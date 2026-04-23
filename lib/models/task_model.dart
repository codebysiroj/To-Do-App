import 'package:first_flutter_project/utils/enums.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;
  final TaskCategory category;
  final TaskStatus taskStatus;

  const TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.taskStatus,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category.name,
      "taskStatus": taskStatus.name,
    };
  }

  TaskModel copyWith({
    final String? id,
    final String? title,
    final String? description,
    final TaskCategory? category,
    final TaskStatus? taskStatus,
  }) => TaskModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    taskStatus: taskStatus ?? this.taskStatus,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
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
