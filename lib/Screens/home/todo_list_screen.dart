import 'package:flutter/material.dart';

import '../../enums/app_enums.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({required this.todoScreenType, super.key});

  final TodoScreenType todoScreenType;

  @override
  State<TodoListScreen> createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void scrollToTop() {
    //_itemScrollController.scrollTo(index: 0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
