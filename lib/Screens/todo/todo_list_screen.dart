import 'package:Task_ToDo/Screens/todo/todo_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../enums/app_enums.dart';
import '../../firebase/services/data_service.dart';
import '../../navigation/navigation_utils.dart';
import '../../navigation/router_configs.dart';
import '../../network/models/todo/task.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({required this.todoScreenType, super.key});

  final TodoScreenType todoScreenType;

  @override
  State<TodoListScreen> createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final _dataService = DataService.instance;

  TodoScreenType get todoScreenType => widget.todoScreenType;

  Stream<QuerySnapshot<Task>> getStream() {
    Stream<QuerySnapshot<Task>> _stream;
    switch (todoScreenType) {
      case TodoScreenType.created:
        _stream = _dataService.getOwnedTask();
        break;
      case TodoScreenType.joined:
        _stream = _dataService.getJoinedTask();
        break;
    }

    return _stream;
  }

  @override
  void initState() {
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (todoScreenType) {
        case TodoScreenType.created:
          _stream = _dataService.getOwnedToDos();
          break;
        case TodoScreenType.joined:
          _stream = _dataService.getJoinedToDos();
          break;
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return _mainWidget;
  }

  void scrollToTop() {
    //_itemScrollController.scrollTo(index: 0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Widget get _mainWidget {
    return StreamBuilder<QuerySnapshot<Task>>(
      stream: getStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        final todos = snapshot.requireData.docs;
        if (todos.isEmpty) {
          return const Center(
            child: Text('No Todos Added Yet!', style: TextStyle(color: Colors.white)),
          );
        }

        return _listOfTodos(todos);
      },
    );
  }

  Widget _listOfTodos(List<QueryDocumentSnapshot<Task>> todos) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 8),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final document = todos[index];
          final docId = document.id;
          final task = document.data();

          return ToDoCardWidget(docId: docId, task: task, onTap: () {
            final routeObject = CreateTaskScreenRouteObject(docId: docId, task: task);
            NavigationUtils.instance.moveToCreateTaskScreen(context: context, routeObject: routeObject);
          });
        },
      ),
    );
  }
}
