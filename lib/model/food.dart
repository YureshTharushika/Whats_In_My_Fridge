import 'dart:convert';

final String tableFoods = 'foods';

class FoodFields {
  static final List<String> values = [
    id,
    title,
    category,
    isExpired,
    createdTime,
    expiryTime
  ];
  static final String id = '_id';
  static final String title = 'title';
  static final String category = 'category';
  static final String isExpired = 'isExpired';
  static final String createdTime = 'createdTime';
  static final String expiryTime = 'expiryTime';
}

class Food {
  final int? id;
  final String title;
  final String category;
  final bool isExpired;
  final DateTime createdTime;
  final DateTime expiryTime;

  const Food(
      {this.id,
      required this.title,
      required this.category,
      required this.isExpired,
      required this.createdTime,
      required this.expiryTime});

  Food copy(
          {int? id,
          String? title,
          String? category,
          bool? isExpired,
          DateTime? createdTime,
          DateTime? expiryTime}) =>
      Food(
          id: id ?? this.id,
          title: title ?? this.title,
          category: category ?? this.category,
          isExpired: isExpired ?? this.isExpired,
          createdTime: createdTime ?? this.createdTime,
          expiryTime: expiryTime ?? this.expiryTime);

  static Food fromJson(Map<String, Object?> json) => Food(
        id: json[FoodFields.id] as int?,
        title: json[FoodFields.title] as String,
        category: json[FoodFields.category] as String,
        isExpired: json[FoodFields.isExpired] == 1,
        createdTime: DateTime.parse(json[FoodFields.createdTime] as String),
        expiryTime: DateTime.parse(json[FoodFields.expiryTime] as String),
      );

  Map<String, Object?> toJson() => {
        FoodFields.id: id,
        FoodFields.title: title,
        FoodFields.category: category,
        FoodFields.isExpired: isExpired ? 1 : 0,
        FoodFields.createdTime: createdTime.toIso8601String(),
        FoodFields.expiryTime: expiryTime.toIso8601String()
      };
}
