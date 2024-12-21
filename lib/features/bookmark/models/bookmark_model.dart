// To parse this JSON data, do
//
//     final bookmarkEntry = bookmarkEntryFromJson(jsonString);

import 'dart:convert';

BookmarkEntry bookmarkEntryFromJson(String str) => BookmarkEntry.fromJson(json.decode(str));

String bookmarkEntryToJson(BookmarkEntry data) => json.encode(data.toJson());

class BookmarkEntry {
    List<Bookmark> bookmarks;

    BookmarkEntry({
        required this.bookmarks,
    });

    factory BookmarkEntry.fromJson(Map<String, dynamic> json) => BookmarkEntry(
        bookmarks: List<Bookmark>.from(json["bookmarks"].map((x) => Bookmark.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bookmarks": List<dynamic>.from(bookmarks.map((x) => x.toJson())),
    };
}

class Bookmark {
    int id;
    String userUsername;
    String restaurantName;
    String dishName;
    int dishId;

    Bookmark({
        required this.id,
        required this.userUsername,
        required this.restaurantName,
        required this.dishName,
        required this.dishId,
    });

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        userUsername: json["user__username"],
        restaurantName: json["restaurant__name"],
        dishName: json["dish__name"],
        dishId: json['dish__id'],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user__username": userUsername,
        "restaurant__name": restaurantName,
        "dish__name": dishName,
        "dish__id" : dishId,
    };
}
