class Task {
  int? id;
  String title;
  String description;
  String date;
  String time;
  bool isCompleted;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
