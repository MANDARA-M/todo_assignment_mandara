import 'package:flutter/material.dart';

import '../../enums/app_enums.dart';
import '../../firebase/services/dataservice.dart';
import '../../network/models/todo/task.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({required this.todoScreenType, super.key});

  final TodoScreenType todoScreenType;

  @override
  State<TodoListScreen> createState() => TodoListScreenState();
}

class TodoListScreenState extends State<TodoListScreen> {
  final DataService _dataService = DataService.instance;

  @override
  Widget build(BuildContext context) {
    return _mainWidget;
  }

  void scrollToTop() {
    //_itemScrollController.scrollTo(index: 0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  Widget get _mainWidget {
    return SizedBox(
      height: MediaQuery.heightOf(context) * 0.70,
      width: MediaQuery.widthOf(context),
      child: StreamBuilder(
        stream: _dataService.getToDos(),
        builder: (context, snapshot) {
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return const Center(child: Text('No Todos Added Yet!'));
          }
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 8),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final taskData = todos[index].data();
                final task = taskData as Task;
                final uid = task.uid;
                return ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  tileColor: Theme.of(context).colorScheme.tertiary,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Id: $uid', style: TextStyle(color: Colors.white)),
                      Text(
                        task.title,
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(task.description, style: TextStyle(color: Colors.white)),
                      //Text(DateFormat('yyyy-MM-dd – kk:mm').format(task.createdAt!.toDate()), style: TextStyle(color: Colors.white,)),
                    ],
                  ),
                  leading: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      //showEditDialog(task, id);
                    },
                    icon: Icon(Icons.edit),
                  ),
                  trailing: Checkbox(
                    shape: CircleBorder(),
                    value: task.isCompleted,
                    onChanged: (value) {
                      /*Task updateTask = task.copyWith(isCompleted: !task.isCompleted, updatedAt: Timestamp.now());
                              _dataService.updateToDo(id, updateTask);*/
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
