class Task {
  final String? id;
  final String title;
  final String description;
  final int dueDateMillis;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.dueDateMillis,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      dueDateMillis: json['dueDateMillis'],
    );
  }


  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      dueDateMillis: map['dueDateMillis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDateMillis': dueDateMillis,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDateMillis': dueDateMillis,
    };
  }

}
