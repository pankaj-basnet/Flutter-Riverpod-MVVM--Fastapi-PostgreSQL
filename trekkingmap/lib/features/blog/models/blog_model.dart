// ignore_for_file: non_constant_identifier_names
import 'package:flutter/foundation.dart'; // @immutable

class BlogModel {
  BlogModel({
    required this.id, 
    required Map<String, dynamic> json,
  })  : title = json["uid"],
        photo_url = json["photo_url"],
        description = json["description"];

  final String id;
  final String title;
  // final String subSectionNo;
  final String photo_url;
  final String description;
}

@immutable
class FirebaseFieldName {
  static const userId = 'uid';
  static const blogId = 'blog_id';
  static const comment = 'comment';
 
  const FirebaseFieldName._();
}
