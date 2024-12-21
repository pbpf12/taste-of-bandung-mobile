// To parse this JSON data, do
//
//     final dishesLanding = dishesLandingFromJson(jsonString);

import 'dart:convert';

List<DishesLanding> dishesLandingFromJson(String str) => List<DishesLanding>.from(json.decode(str).map((x) => DishesLanding.fromJson(x)));

String dishesLandingToJson(List<DishesLanding> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DishesLanding {
    Model model;
    int pk;
    Fields fields;

    DishesLanding({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory DishesLanding.fromJson(Map<String, dynamic> json) => DishesLanding(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int restaurant;
    int category;
    String name;
    String description;
    String? averageRating;
    String price;
    String image;
    int bookmarkCount;

    Fields({
        required this.restaurant,
        required this.category,
        required this.name,
        required this.description,
        required this.averageRating,
        required this.price,
        required this.image,
        required this.bookmarkCount,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        restaurant: json["restaurant"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        averageRating: json["average_rating"],
        price: json["price"],
        image: json["image"],
        bookmarkCount: json["bookmark_count"],
    );

    Map<String, dynamic> toJson() => {
        "restaurant": restaurant,
        "category": category,
        "name": name,
        "description": description,
        "average_rating": averageRating,
        "price": price,
        "image": image,
        "bookmark_count": bookmarkCount,
    };
}

enum Model {
    SEARCH_DISH
}

final modelValues = EnumValues({
    "search.dish": Model.SEARCH_DISH
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
