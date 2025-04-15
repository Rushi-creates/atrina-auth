import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool isDone;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime? deadline;

  @HiveField(6)
  int priority;

  @HiveField(7)
  String? labelList;

  Todo({
    required this.id,
    required this.title,
    this.description,
    this.isDone = false,
    required this.createdAt,
    this.deadline,
    this.priority = 0, // Default priority (0 = none, 1 = low, 2 = medium, 3 = high)
    this.labelList,
  });

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    DateTime? createdAt,
    DateTime? deadline,
    int? priority,
    String? labelList,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      labelList: labelList ?? this.labelList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'deadline': deadline?.millisecondsSinceEpoch,
      'priority': priority,
      'labelList': labelList,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map, String id) {
    return Todo(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] ?? false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      deadline: map['deadline'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['deadline']) 
          : null,
      priority: map['priority'] ?? 0,
      labelList: map['labelList'],
    );
  }
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Todo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          isDone == other.isDone &&
          createdAt == other.createdAt &&
          deadline == other.deadline &&
          priority == other.priority &&
          labelList == other.labelList;

  @override
  int get hashCode => id.hashCode ^ 
                     title.hashCode ^ 
                     description.hashCode ^ 
                     isDone.hashCode ^ 
                     createdAt.hashCode ^ 
                     deadline.hashCode ^ 
                     priority.hashCode ^ 
                     labelList.hashCode;
}