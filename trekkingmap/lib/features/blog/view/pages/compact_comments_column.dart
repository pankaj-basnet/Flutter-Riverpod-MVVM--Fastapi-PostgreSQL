import 'package:flutter/material.dart';
import 'package:trekkingmap/features/blog/models/comment_model.dart';

class CompactCommentsColumn extends StatelessWidget {
  final Iterable<CommentModel> comments;
  const CompactCommentsColumn({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: comments.map(
          (comment) {
            // return CompactCommentTile(
            //   comment: comment,
            // );
            return Row(
              children: [
                Text(
                  " ${comment.id} user : ",
                  style: const  TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(" ${comment.comment}"),
                const Divider(),
              ],
            );
          },
        ).toList(),
      ),
    );
  }
}
