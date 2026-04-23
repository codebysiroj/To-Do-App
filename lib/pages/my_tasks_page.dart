import 'dart:convert';

import 'package:first_flutter_project/pages/add_task_page.dart';
import 'package:first_flutter_project/utils/app_extensions.dart';
import 'package:first_flutter_project/utils/constants.dart';
import 'package:first_flutter_project/utils/enums.dart';
import 'package:first_flutter_project/widgets/task_card_widget.dart';
import 'package:first_flutter_project/pages/task_detail_page.dart';
import 'package:first_flutter_project/models/task_model.dart';
import 'package:first_flutter_project/widgets/task_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({super.key});

  @override
  State<MyTasksPage> createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  late SharedPreferences prefs;

  List<TaskModel> allTasksList = [];
  List<TaskModel> pendingTasksList = [];
  List<TaskModel> completedTasksList = [];

  List<TaskModel> getResultList() {
    switch (selectedTaskStatus) {
      case TaskStatus.all:
        return allTasksList;
      case TaskStatus.pending:
        return pendingTasksList;
      case TaskStatus.completed:
        return completedTasksList;
    }
  }

  TaskStatus selectedTaskStatus = TaskStatus.all;

  Future<void> initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    loadTasksFromLocalStorage();
  }

  void loadTasksFromLocalStorage() {
    List<String> tasksStringList =
        prefs.getStringList(AppConstants.taskListKey) ?? [];

    allTasksList = tasksStringList.map((item) {
      final Map<String, dynamic> json = jsonDecode(item);
      return TaskModel.fromJson(json);
    }).toList();

    pendingTasksList = allTasksList
        .where((item) => item.taskStatus == TaskStatus.pending)
        .toList();

    completedTasksList = allTasksList
        .where((item) => item.taskStatus == TaskStatus.completed)
        .toList();
    setState(() {});
  }

  void updateTask(TaskModel currentTask) async {
    final index = allTasksList.indexWhere((item) => item.id == currentTask.id);
    allTasksList[index] = currentTask.copyWith(
      taskStatus: currentTask.taskStatus == TaskStatus.pending
          ? TaskStatus.completed
          : TaskStatus.pending,
    );

    final List<String> taskStringList = [];

    for (TaskModel task in allTasksList) {
      taskStringList.add(jsonEncode(task.toJson()));
    }
    await prefs.setStringList(AppConstants.taskListKey, taskStringList);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          "My Tasks",
          style: TextStyle(color: Colors.white, fontWeight: .w500),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: Colors.white,
            child: Row(
              spacing: 20,
              children: List.generate(TaskStatus.values.length, (index) {
                final currentTaskStatus = TaskStatus.values[index];
                return TaskStatusWidget(
                  taskStatus: currentTaskStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedTaskStatus = value;
                    });
                  },
                  isSelected: currentTaskStatus == selectedTaskStatus,
                );
              }),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(24),
              itemCount: getResultList().length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              itemBuilder: (context, index) {
                final task = getResultList()[index];
                return TaskCardWidget(
                  task: task,
                  onRadioTap: () {
                    // Todo: Bu yerni bosganda task pending holatidan completedga o'tishi kerak
                    updateTask(task);
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskDetailPage()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        shape: CircleBorder(),
        onPressed: () async {
          final bool? shouldUpdate = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );

          if (shouldUpdate == null) return;
          loadTasksFromLocalStorage();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
