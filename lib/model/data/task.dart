class Task {
  final int id;
  final String title;
  final String description;
  final int dueDateMillis;
  bool isSynced;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDateMillis,
    this.isSynced = false, // default value is false
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDateMillis: json['dueDateMillis'],
      isSynced: json['isSynced'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDateMillis': dueDateMillis,
      'isSynced': isSynced,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDateMillis: map['dueDateMillis'],
      isSynced: map['isSynced'] ?? false,
    );
  }
}
