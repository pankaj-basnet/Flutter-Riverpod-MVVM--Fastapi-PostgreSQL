// ignore_for_file: non_constant_identifier_names


import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.photo_url,
    required this.description,
  });

  final String id;
  final String title;
  final String price;
  final String photo_url;
  final String description;

  
  ProductModel copyWith({
    String? id,
    String? title,
    String? price,
    String? photo_url,
    String? description,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      photo_url: photo_url ?? this.photo_url,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'photo_url': photo_url,
      'description': description,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      price: map['price'] as String,
      photo_url: map['photo_url'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, price: $price, photo_url: $photo_url, description: $description )';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.photo_url == photo_url &&
        other.description == description ;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        photo_url.hashCode ^
        description.hashCode ;
  }
}
