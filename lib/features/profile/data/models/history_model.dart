class HistoryModel {
  final int id;
  final int userId;
  final int dishId;
  final DateTime createdAt;

  HistoryModel({
    required this.id,
    required this.userId,
    required this.dishId,
    required this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      dishId: json['dishId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }

  HistoryModel copyWith({
    int? id,
    int? userId,
    int? dishId,
    DateTime? createdAt,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dishId: dishId ?? this.dishId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
