// To parse this JSON data, do
//
//     final suggestion = suggestionFromJson(jsonString);

import 'dart:convert';

List<Suggestion> suggestionFromJson(String str) => List<Suggestion>.from(json.decode(str).map((x) => Suggestion.fromJson(x)));

String suggestionToJson(List<Suggestion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Suggestion {
    String model;
    int pk;
    Fields fields;

    Suggestion({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Suggestion.fromJson(Map<String, dynamic> json) => Suggestion(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String suggestionMessage;

    Fields({
        required this.user,
        required this.suggestionMessage,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        suggestionMessage: json["suggestionMessage"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "suggestionMessage": suggestionMessage,
    };
}
