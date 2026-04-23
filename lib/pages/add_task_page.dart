import 'dart:convert';

import 'package:first_flutter_project/utils/constants.dart';
import 'package:first_flutter_project/utils/enums.dart';
import 'package:first_flutter_project/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  late SharedPreferences prefs;

  TaskCategory? selectedTaskCategory;

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveTask() async {
    final List<String> taskStringList =
        prefs.getStringList(AppConstants.taskListKey) ?? <String>[];

    final TaskModel task = TaskModel(
      id: Uuid().v4(),
      title: titleController.text,
      description: descriptionController.text,
      category: selectedTaskCategory!,
      taskStatus: TaskStatus.pending,
    );

    final String taskJson = jsonEncode(task.toJson());

    taskStringList.add(taskJson);

    await prefs.setStringList(AppConstants.taskListKey, taskStringList);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Add Task",
          style: TextStyle(color: Colors.white, fontWeight: .w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Task Title", style: TextStyle(fontWeight: .w600)),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter task title",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text("Description", style: TextStyle(fontWeight: .w600)),
            const SizedBox(height: 12),
            TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Enter task description",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(
                    width: 1.5,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text("Category", style: TextStyle(fontWeight: .w600)),
            const SizedBox(height: 12),
            Row(
              spacing: 12,
              children: List.generate(TaskCategory.values.length, (index) {
                final category = TaskCategory.values[index];
                final bool isSelected =
                    category.name == selectedTaskCategory?.name;
                return Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      setState(() {
                        if (selectedTaskCategory == category) {
                          selectedTaskCategory = null;
                        } else {
                          selectedTaskCategory = category;
                        }
                      });
                    },
                    child: Container(
                      alignment: .center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: Text(category.name),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed:
                  (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      selectedTaskCategory == null)
                  ? null
                  : saveTask,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text("Save Task"),
            ),
          ],
        ),
      ),
    );
  }
}
