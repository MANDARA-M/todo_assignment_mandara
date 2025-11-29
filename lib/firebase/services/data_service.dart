import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inSTA/utilities/storage/shared_preference/shared_preferences_util.dart';

import '../../network/models/todo/task.dart';

const String toDoCollection = 'todos';

class DataService {
  DataService._() {
    initialiseData();
  }

  static DataService? _instance;

  static final DataService instance = _instance ??= DataService._();

  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Task> todoCreatedRef;

  String get userId => SharedPreferencesUtil.instance.userId;

  void initialiseData() {
    todoCreatedRef = _firestore
        .collection(toDoCollection)
        .withConverter<Task>(fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!), toFirestore: (task, _) => task.toJson());
  }

  Stream<QuerySnapshot<Task>> getOwnedToDos() {
    final ownerTasksQuery = todoCreatedRef.where('ownerId', isEqualTo: userId);
    return ownerTasksQuery.snapshots();
  }

  Stream<QuerySnapshot<Task>> getJoinedToDos() {
    final ownerTasksQuery = todoCreatedRef.where('sharedWith', arrayContains: userId);
    return ownerTasksQuery.snapshots();
  }

  void addToDo(Task task) async {
    await todoCreatedRef.add(task);
  }

  void updateToDo({required String docId, required Task task}) async {
    await todoCreatedRef.doc(docId).update(task.toJson());
  }

  void deleteToDo(String toDoId) async {
    await todoCreatedRef.doc(toDoId).delete();
  }
}
