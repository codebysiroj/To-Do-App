import 'dart:convert';

import 'package:first_flutter_project/add_task_page.dart';
import 'package:first_flutter_project/constants.dart';
import 'package:first_flutter_project/enums.dart';
import 'package:first_flutter_project/task_model.dart';
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
      body: ListView.separated(
        padding: EdgeInsets.all(24),
        itemCount: allTasksList.length,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 12);
        },
        itemBuilder: (context, index) {
          final task = allTasksList[index];
          return Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                ),
                Expanded(child: Column(children: [Text(task.title)])),
              ],
            ),
          );
        },
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
