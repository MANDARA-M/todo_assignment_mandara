import 'package:cloud_firestore/cloud_firestore.dart';

import '../../network/models/todo/task.dart';

const String toDoCollection = 'todos';

class DataService {
  DataService._() {
    initialiseData();
  }

  static DataService? _instance;

  static final DataService instance = _instance ??= DataService._();

  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference todoCreatedRef;
  late final CollectionReference todoJoinedRef;

  void initialiseData() {
    /*toDoRef = _firestore
        .collection(toDoCollection)
        .withConverter<Task>(fromFirestore: (snapshot, _) => Task.fromMap(snapshot.data()!), toFirestore: (task, _) => task.toJson());*/

    todoCreatedRef = _firestore
        .collection(toDoCollection)
        .withConverter<Task>(fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!), toFirestore: (task, _) => task.toJson());
  }

  Stream<QuerySnapshot> getToDos() {
    return todoCreatedRef.snapshots();
  }

  void addToDo(Task task) async {
    await todoCreatedRef.add(task);
  }

  void updateToDo(String toDoId, Task task) async {
    await todoCreatedRef.doc(toDoId).update(task.toJson());
  }

  void deleteToDo(String toDoId) async {
    await todoCreatedRef.doc(toDoId).delete();
  }
}
