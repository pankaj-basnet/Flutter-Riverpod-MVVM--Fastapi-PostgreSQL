import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekkingmap/features/blog/repositories/blog_and_comments_repository_provider.dart';
import 'package:trekkingmap/features/blog/view/pages/compact_comments_column.dart';

// Spotify -- ori+prac -- 241215 --  ------->  FIGMA DESIGN --- PRACTICE FILE --- Spotify -- ori+prac -- 241215 -- {{ Spotify
class BlogPage extends ConsumerStatefulWidget {
  // BlogPage = BlogDetailsView
  const BlogPage({super.key});

  //   const BlogPage({
  //   Key? key,
  //   required this.blog,
  // }) : super(key: key);

  @override
  ConsumerState<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends ConsumerState<BlogPage> {
  @override
  Widget build(BuildContext context) {
    const request = RequestForBlogAndComments(
      blogId: "blogId1",
      // limit: 3, // at most 3 comments
    );

    // get blog with comments
    final blogWithComments = ref.watch(
      BlogAndCommentsProvider(
        request,
      ),
    );

    //    ==========================

    return Scaffold(
        appBar: AppBar(
          title: Title(
            color: Colors.red,
            child: const Text("blog page"),
          ),
        ),
        body: blogWithComments.when(
          data: (blogWithCommentsdata) {
            return SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                //    ==========      Blog   (1) ==========

                const Text(
                    "  Flutter + Firebase database for 'blog' + 'comment' "),

                // TITLE + MESSAGE PIC
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Text(
                                  // " *** firebase blog doc id *** ",
                                  "Blog ID : ${blogWithCommentsdata.blog.id}  "),
                              Text(
                                // ">>> Title: 5% Discount on RBB Card payment",
                                "By Content Manager (EmployeeID : ${blogWithCommentsdata.blog.title})",
                                softWrap: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                  // "We bring flexibility, visibility, and streamlined tools to make business parcel delivery smoother, faster, and smarter. Our reliable enterprise delivery service offers businesses fast and secure order fulfilment. "

                                  blogWithCommentsdata.blog.description),
                            ],
                          )),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      blogWithCommentsdata.blog.photo_url),
                                  // image: NetworkImage(
                                  //     "https://m.media-amazon.com/images/I/317-e4E6jZL._SY445_SX342_QL70_FMwebp_.jpg"),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // comments
                Container(
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "Comments Section",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CompactCommentsColumn(
                        comments: blogWithCommentsdata.comments,
                      ),
                    ],
                  ),
                )
              ]),
            ));
          },
          error: (error, stackTrace) {
            return const Text("error in blogpage");
          },
          loading: () {
            return const Text(" loading in blogpage");
          },
        ));

    //    ==========================

    //    ==========      COMMENTS   (2) ==========

    //         Container(
    //           padding: const EdgeInsets.all(8.0),
    //           child: const Column(
    //             children: [Text(" 3 out of 10 comments  /   0 comments")],
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}
