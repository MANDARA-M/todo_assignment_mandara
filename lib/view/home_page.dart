import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/services/dataservice.dart';

import '../model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DataService _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      body: _buildId(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _displayInputDialog();
        },
      ),
    );
  }

  Widget _buildId() {
    return SafeArea(
  child: _buildListView()
    );
}

  Widget _buildListView() {
    return SizedBox(
      height: MediaQuery.heightOf(context) * 0.70,
      width: MediaQuery.widthOf(context),
      child: StreamBuilder(
            stream: _dataService.getToDos(),
            builder: (context, snapshot) {
            List todos = snapshot.data?.docs ?? [];
            if (todos.isEmpty) {
              return const Center(
                child: Text('No Todos Added Yet!'),
              );
            }
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 8,),
                  itemCount: todos.length,
                    itemBuilder: (context, index) {
                    Task task = todos[index].data() as Task;
                    String id = todos[index].id;
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tileColor: Theme.of(context).colorScheme.tertiary,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  Text('Id: ${task.id}', style: TextStyle(color: Colors.white,)),
                                  Text(task.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  Text(task.description, style: TextStyle(color: Colors.white,)),
                                  Text(DateFormat('yyyy-MM-dd – kk:mm').format(task.createdAt!.toDate()), style: TextStyle(color: Colors.white,)),

                            ],
                              ),
                        leading: IconButton( color: Colors.white,
                          onPressed: () {
                            showEditDialog(task, id);
                          },
                          icon: Icon(Icons.edit),),
                        trailing: Checkbox(
                          shape:  CircleBorder(),
                            value: task.isCompleted,
                            onChanged: (value) {
                                Task updateTask = task.copyWith(isCompleted: !task.isCompleted, updatedAt: Timestamp.now());
                                _dataService.updateToDo(id, updateTask);
                        })
                      );
                    }
                ),
              );
            }
        ),
    );
  }

  void _displayInputDialog() async {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController taskIdController = TextEditingController();
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add your TaskId, Title and Description of ur task'),
              content: Column(
                children: [
                  TextFormField( controller: taskIdController, decoration: InputDecoration(hintStyle: TextStyle(color: Colors.black)),),
                  TextField(controller: titleController,),
                  TextField(controller: descriptionController,),
                ],
              ),
              actions: <Widget>[
                MaterialButton(
                  onPressed: () {
                    final createdAt = Timestamp.now();
                    Task toDo = Task(
                        id: taskIdController.text,
                        ownerId: '',
                        title: titleController.text,
                        description: descriptionController.text,
                        createdAt: createdAt,
                    );
                    Navigator.pop(context);
                    titleController.clear();
                    descriptionController.clear();
                    taskIdController.clear();
                    _dataService.addToDo(toDo);
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: Text('Ok', style: TextStyle(color: Colors.white),),
                )
              ],

            );
          }
      );
  }

  void showEditDialog(Task task, String id) {
    TextEditingController titleController = TextEditingController(text: task.title);
    TextEditingController descriptionController = TextEditingController(text: task.description);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit your Task Title and Description'),
            content: Column(
              children: [
                TextField(controller: titleController,),
                TextField(controller: descriptionController,),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  Task updatedTask = task.copyWith(
                    title: titleController.text,
                    description: descriptionController.text,
                    updatedAt: Timestamp.now(),
                  );
                  Navigator.pop(context);
                  _dataService.updateToDo(id, updatedTask);
                },
                color: Theme.of(context).colorScheme.primary,
                child: Text('Update', style: TextStyle(color: Colors.white),),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  _dataService.deleteToDo(id);
                },
                color: Theme.of(context).colorScheme.primary,
                child: Text('Delete', style: TextStyle(color: Colors.white),),
              ),
            ],

          );
        }
    );
  }


}
