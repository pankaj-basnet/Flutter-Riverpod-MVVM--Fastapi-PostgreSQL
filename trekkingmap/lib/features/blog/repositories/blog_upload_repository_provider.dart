// firestore ---- blog collection name created---> "rblog"
// firestore ---- comment collection name created---> "rcomment"

//    ======    self-note  (didnot want to use following code)  ================================

// @riverpod
// BlogRepository blogRepository(BlogRepositoryRef ref) {
//   return BlogRepository();
// }

// class BlogRepository {
//   Future<Either<AppFailure, String>> uploadBlog({    // riva=

//    ======    self-note    ==========================//>>==

//  =========================================================
//  =========================================================

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart'; // @immutable

import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogUploadRepositoryProvider =
    StateNotifierProvider<BlogUploadRepositoryNotifier, bool>(
        (ref) => BlogUploadRepositoryNotifier());

class BlogUploadRepositoryNotifier extends StateNotifier<bool> {
  BlogUploadRepositoryNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> upload_blog() async {
    isLoading = true;

    //hard code (remove later)

    final payload = BlogPayload(
        title: "Same day delivery",
        photo_url:
            "https://m.media-amazon.com/images/G/02/amazonshipping/Marketing/What_is_Amazon_Shipping_blog_in_text_image_994_x_548.png",
        description: "Refashion fast delivery");

    try {
      await FirebaseFirestore.instance.collection("rblog").add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

//  =========================================================
//  =========================================================

@immutable
class BlogPayload extends MapView<String, dynamic> {
  BlogPayload({
    required String title,
    required String photo_url,
    required String description,
  }) : super(
          {
            "title": title,
            "photo_url": photo_url,
            "description": description,
          },
        );
}

//  =========================================================
//  =========================================================
