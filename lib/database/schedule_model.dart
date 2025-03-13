class Schedule {
  int? id;
  String title;
  String description;
  String date;
  String time;
  bool isEnabled;

  Schedule({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isEnabled = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'isEnabled': isEnabled ? 1 : 0,
    };
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
      isEnabled: map['isEnabled'] == 1,
    );
  }
}
