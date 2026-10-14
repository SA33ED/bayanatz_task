import 'package:cloud_firestore/cloud_firestore.dart';

class TaskBoardModel {
  const TaskBoardModel({
    required this.id,
    required this.name,
    required this.department,
    required this.ownershipStatus,
    required this.description,
    required this.createdAt,
    required this.memberImageUrls,
    required this.membersCount,
    required this.createdBy,
  });

  final String id;
  final String name;
  final String department;
  final String ownershipStatus;
  final String description;
  final DateTime createdAt;
  final List<String> memberImageUrls;
  final int membersCount;
  final String createdBy;

  factory TaskBoardModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? <String, dynamic>{};
    final timestamp = data['createdAt'];

    return TaskBoardModel(
      id: document.id,
      name: data['name'] as String? ?? '',
      department: data['department'] as String? ?? '',
      ownershipStatus: data['ownershipStatus'] as String? ?? 'owner',
      description: data['description'] as String? ?? '',
      createdAt: timestamp is Timestamp ? timestamp.toDate() : DateTime.now(),
      memberImageUrls: List<String>.from(
        data['memberImageUrls'] as List<dynamic>? ?? const <dynamic>[],
      ),
      membersCount: data['membersCount'] as int? ?? 0,
      createdBy: data['createdBy'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name.trim(),
      'department': department,
      'ownershipStatus': ownershipStatus,
      'description': description.trim(),
      'createdAt': Timestamp.fromDate(createdAt),
      'memberImageUrls': memberImageUrls,
      'membersCount': membersCount,
      'createdBy': createdBy,
    };
  }
}
