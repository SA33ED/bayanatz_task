import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_board_model.dart';

class HomeRepo {
  HomeRepo(this.firestore, this.auth);

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CollectionReference<Map<String, dynamic>> get _boardsCollection =>
      firestore.collection('task_boards');

  Future<void> ensureSignedIn() async {
    if (auth.currentUser == null) {
      await auth.signInAnonymously();
    }
  }

  Future<List<TaskBoardModel>> getTaskBoards() async {
    await ensureSignedIn();
    final snapshot = await _boardsCollection
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map(TaskBoardModel.fromFirestore).toList();
  }

  Future<void> addTaskBoard(TaskBoardModel board) async {
    await ensureSignedIn();
    final userId = auth.currentUser!.uid;
    final boardToSave = TaskBoardModel(
      id: board.id,
      name: board.name,
      department: board.department,
      ownershipStatus: board.ownershipStatus,
      description: board.description,
      createdAt: DateTime.now(),
      memberImageUrls: board.memberImageUrls,
      membersCount: board.membersCount,
      createdBy: userId,
    );
    await _boardsCollection.add(boardToSave.toFirestore());
  }
}
