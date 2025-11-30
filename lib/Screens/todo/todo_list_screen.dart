import 'package:Task_ToDo/Screens/todo/todo_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

  List<QueryDocumentSnapshot<Task>> todos = [];

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

        todos.clear();
        todos.addAll(snapshot.requireData.docs);

        if (todos.isEmpty) {
          return const Center(
            child: Text('No Todos Added Yet!', style: TextStyle(color: Colors.white)),
          );
        }

        return _listOfTodos;
      },
    );
  }

  Widget get _listOfTodos {
    final child = LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _mobileLayout;
        } else if (constraints.maxWidth < 1000) {
          return _tabletScreenLayout;
        } else {
          return _biggerScreenLayout;
        }
      },
    );

    return Padding(padding: const EdgeInsets.all(12.0), child: child);
  }

  Widget get _mobileLayout => ListView.separated(separatorBuilder: (context, index) => SizedBox(height: 8), itemCount: todos.length, itemBuilder: _itemBuilder);

  Widget get _tabletScreenLayout => _gridLayout(crossAxisCount: 2);

  Widget get _biggerScreenLayout => _gridLayout(crossAxisCount: 3);

  Widget _gridLayout({required int crossAxisCount}) {
    return MasonryGridView.count(
      itemCount: todos.length,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      itemBuilder: _itemBuilder,
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final document = todos[index];
    final docId = document.id;
    final task = document.data();

    return ToDoCardWidget(
      docId: docId,
      task: task,
      onTap: () {
        final routeObject = CreateTaskScreenRouteObject(docId: docId, task: task);
        NavigationUtils.instance.moveToCreateTaskScreen(context: context, routeObject: routeObject);
      },
    );
  }
}
