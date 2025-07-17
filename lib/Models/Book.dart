import 'dart:convert';

// Parse JSON to a single Book
Book bookFromJson(String str) => Book.fromJson(json.decode(str));

// Convert Book to JSON string
String bookToJson(Book data) => json.encode(data.toJson());

// Parse JSON to a List<Book>
List<Book> bookListfromJson(String str) {
  final jsonData = json.decode(str) as List;
  return jsonData.map((item) => Book.fromJson(item)).toList();
}

class Book {
  int? id; // Optional - comes from server only
  String author;
  String addedBy;
  String title;
  String desc;
  String coverPageUrl;
  int year;
  String genre;
  String language;
  int pages;
  String publisher;
  double rating;

  Book({
    this.id, // Optional
    required this.author,
    required this.addedBy,
    required this.title,
    required this.desc,
    required this.coverPageUrl,
    required this.year,
    required this.genre,
    required this.language,
    required this.pages,
    required this.publisher,
    required this.rating,
  });

  // Factory to create Book object from JSON
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"],
    author: json["author"],
    addedBy: json["addedBy"],
    title: json["title"],
    desc: json["desc"],
    coverPageUrl: json["coverPageUrl"],
    year: json["year"],
    genre: json["genre"],
    language: json["language"],
    pages: json["pages"],
    publisher: json["publisher"],
    rating: json["rating"]?.toDouble(),
  );

  // Convert Book object to JSON (excluding id)
  Map<String, dynamic> toJson() => {
    "author": author,
    "addedBy": addedBy,
    "title": title,
    "desc": desc,
    "coverPageUrl": coverPageUrl,
    "year": year,
    "genre": genre,
    "language": language,
    "pages": pages,
    "publisher": publisher,
    "rating": rating,
  };
}
