class Task {
  final int id;
  final String title;
  final String description;
  final int dueDateMillis;
  bool _isSynced;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDateMillis,
    bool isSynced = false,
  }) : _isSynced = isSynced;

  bool get isSynced => _isSynced;

  set isSynced(bool value) {
    _isSynced = value;
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDateMillis: json['dueDateMillis'],
      isSynced: json['isSynced'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDateMillis': dueDateMillis,
      'isSynced': _isSynced ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDateMillis: map['dueDateMillis'],
      isSynced: map['isSynced'] == 1,
    );
  }
}
