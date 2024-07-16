class Task {
  String id;
  String title;
  String description;
  int priority;
  DateTime dueDate;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'priority': priority,
    'dueDate': dueDate.toIso8601String(),
    'isCompleted': isCompleted,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    priority: json['priority'],
    dueDate: DateTime.parse(json['dueDate']),
    isCompleted: json['isCompleted'],
  );
}
