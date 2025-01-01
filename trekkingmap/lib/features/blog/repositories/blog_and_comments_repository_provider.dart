import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart'; // IterableEquality

import 'package:flutter/foundation.dart'; // @immutable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekkingmap/features/blog/models/blog_model.dart';
import 'package:trekkingmap/features/blog/models/comment_model.dart';

// jdk 17 ------ 

// ignore: non_constant_identifier_names
final BlogAndCommentsProvider = StreamProvider.family
    .autoDispose<BlogAndComments, RequestForBlogAndComments>((
  ref,
  RequestForBlogAndComments request,
) {
  final controller = StreamController<BlogAndComments>();

  BlogModel? blog;
  Iterable<CommentModel>? comments;

  void notify() {
    final localBlog = blog;
    if (localBlog == null) {
      return;
    }

    final outputComments = (comments ?? []);

    final result = BlogAndComments(
      blog: localBlog,
      comments: outputComments,
    );
    controller.sink.add(result);
  }

  // watch changes to the blog

  final blogSub = FirebaseFirestore.instance
      .collection(
        "rblog",
      )
      .where(
        FieldPath.documentId,
        isEqualTo: request.blogId,
      )
      .limit(1)
      .snapshots()
      .listen(
    (snapshot) {
      if (snapshot.docs.isEmpty) {
        blog = null;
        comments = null;
        notify();
        return;
      }
      final doc = snapshot.docs.first;
      if (doc.metadata.hasPendingWrites) {
        return;
      }
      blog = BlogModel(
        id: doc.id,
        json: doc.data(),
      );
      notify();
    },
  );

  // watch changes to the comments

  final commentsQuery = FirebaseFirestore.instance
      .collection(
        "rcomment",
      )
      .where(
        "blog_id",
        isEqualTo: request.blogId,
      ) ;

  final limitedCommentsQuery = request.limit != null
      ? commentsQuery.limit(request.limit!)
      : commentsQuery;

  final commentsSub = limitedCommentsQuery.snapshots().listen(
    (snapshot) {
      comments = snapshot.docs
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => CommentModel(
              doc.data(),
              id: doc.id,
            ),
          );
      notify();
    },
  );

  ref.onDispose(() {
    blogSub.cancel();
    commentsSub.cancel();
    controller.close();
  });

  return controller.stream;
});

@immutable
class BlogAndComments {
  final BlogModel blog;
  final Iterable<CommentModel> comments;

  const BlogAndComments({
    required this.blog,
    required this.comments,
  });

  @override
  bool operator ==(covariant BlogAndComments other) =>
      blog == other.blog &&
      const IterableEquality().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll([
        blog,
        comments,
      ]);
}

@immutable
class RequestForBlogAndComments {
  final String blogId;
  final int? limit;

  const RequestForBlogAndComments({
    required this.blogId,
    this.limit,
  });

  @override
  bool operator ==(covariant RequestForBlogAndComments other) =>
      blogId == other.blogId && limit == other.limit;

  @override
  int get hashCode => Object.hashAll(
        [
          blogId,
          limit,
        ],
      );
}
