// // class Todo {
// //   final String id;
// //   final String title;
// //   final bool isDone;
// //   final DateTime createdAt; // New DateTime field

// //   Todo({
// //     required this.id,
// //     required this.title,
// //     required this.isDone,
// //     required this.createdAt,
// //   });

// //   factory Todo.fromMap(Map<String, dynamic> map) {
// //     return Todo(
// //       id: map['id'] ?? '',
// //       title: map['title'] ?? 'Untitled',
// //       isDone: map['isDone'] ?? false,
// //       createdAt: map['createdAt'] != null
// //           ? DateTime.parse(map['createdAt']) // Convert from string
// //           : DateTime.now(), // Default to current time if missing
// //     );
// //   }

// //   Map<String, dynamic> toMap() {
// //     return {
// //       'id': id,
// //       'title': title,
// //       'isDone': isDone,
// //       'createdAt': createdAt.toIso8601String(), // Convert to string for storage
// //     };
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class Todo {
//   final String id;
//   final String title;
//   final bool isDone;
//   final DateTime createdAt; // DateTime field

//   Todo({
//     required this.id,
//     required this.title,
//     required this.isDone,
//     required this.createdAt,
//   });

//   factory Todo.fromMap(Map<String, dynamic> map, String documentId) {
//     return Todo(
//       id: documentId,
//       title: map['title'] ?? 'Untitled',
//       isDone: map['isDone'] ?? false,
//       createdAt: map['createdAt'] != null
//           ? (map['createdAt'] as Timestamp).toDate() // Convert Firestore Timestamp to DateTime
//           : DateTime.now(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'isDone': isDone,
//       'createdAt': Timestamp.fromDate(createdAt), // Convert DateTime to Firestore Timestamp
//     };
//   }
// }


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt; // DateTime field

  Todo({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  factory Todo.fromMap(Map<String, dynamic> map, String documentId) {
    return Todo(
      id: documentId,
      title: map['title'] ?? 'Untitled',
      isDone: map['isDone'] ?? false,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate() // Convert Firestore Timestamp to DateTime
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
      'createdAt': Timestamp.fromDate(createdAt), // Convert DateTime to Firestore Timestamp
    };
  }

    String toJson() {
  return jsonEncode(toMap());
}

  // CopyWith method to create a copy of the Todo with modified fields
  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
