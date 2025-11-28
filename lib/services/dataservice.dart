import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task.dart';

const String toDoCollection = 'todos';

class DataService {
  final  _firestore = FirebaseFirestore.instance;

  late final CollectionReference toDoRef;

     DataService() {
        toDoRef = _firestore.collection(toDoCollection).withConverter<Task>(
            fromFirestore: (snapshot, _) => Task.fromMap(snapshot.data()!),
            toFirestore: (task, _) => task.toJson(),
        );
     }

     
     Stream<QuerySnapshot> getToDos() {
       return toDoRef.snapshots();
     }

     void addToDo(Task task) async {
       await toDoRef.add(task);
     }

  void updateToDo(String toDoId, Task task) async {
    await toDoRef.doc(toDoId).update(task.toJson());
  }


  void deleteToDo(String toDoId) async{
       await toDoRef.doc(toDoId).delete();
  }

}