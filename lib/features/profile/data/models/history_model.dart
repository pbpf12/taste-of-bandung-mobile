import 'package:tasteofbandung/features/search/data/models/dish_model.dart';

class HistoryModel {
  final DishModel dish;
  final DateTime createdAt;

  HistoryModel({
    required this.dish,
    required this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      dish: DishModel.fromJson(json['dish'] ?? {}),
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
    );
  }

  HistoryModel copyWith({
    DishModel? dish,
    DateTime? createdAt,
  }) {
    return HistoryModel(
      dish: dish ?? this.dish,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
