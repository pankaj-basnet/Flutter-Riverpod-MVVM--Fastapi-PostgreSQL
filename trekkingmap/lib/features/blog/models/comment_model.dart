
import 'package:flutter/foundation.dart';  //@immutable

@immutable
class CommentModel {
  final String id;
  final String comment;
  final String blogId;
  CommentModel(Map<String, dynamic> json, {required this.id})
      : comment = json["comment"],
        blogId = json["blog_id"];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          comment == other.comment &&
          blogId == other.blogId;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          comment,
          blogId,
        ],
      );
}
