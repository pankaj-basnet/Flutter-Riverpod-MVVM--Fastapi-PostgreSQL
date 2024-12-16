import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trekkingmap/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trekkingmap/features/home/viewmodel/home_viewmodel.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;

  final pages = const [];

Future<Map<String, dynamic>?>  toFirebase () async{


    var post =  await FirebaseFirestore.instance
        .collection("name")
        .doc("pankaj")
        .set( {"time" :DateTime.now().toIso8601String() });
        // .set( {"current": "time"});
  

  
    var getPost =
        await FirebaseFirestore.instance
        .collection("name")
        .doc("pankaj").get();


        var getPostData = getPost.data();
        



}

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text("Refashion Clothing")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0,),
          Text("----------- ${ FirebaseAuth.instance.currentUser}------"),
          SizedBox(height: 20.0,),
          ref.watch(getAllProductsProvider).when(
                data: (products) {
         
                  return SizedBox(
                      // height: 260,
                      height: 600,

                      // child:
                      // ListView.builder(
                      //   // scrollDirection: Axis.horizontal,
                      //   itemCount: products.length,
                      //   itemBuilder: (context, index) {
                      //     final product = products[index];

                      // ===================================================

                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // number of items in each row
                          mainAxisSpacing: 8.0, // spacing between rows
                          crossAxisSpacing: 8.0, // spacing between columns
                        ),
                        padding: const EdgeInsets.all(8.0), // padding around the grid
                        // itemCount: items.length, // total number of items
                        itemCount: 3, // total number of items
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 130,
                                    height: 130,
                                    decoration: BoxDecoration(
                                      border: Border.all() ,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          product.photo_url,
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      product.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      product.price,
                                      style: const TextStyle(
                                        color: Pallete.subtitleText,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                      //   },
                      // ),
                      );
                },
                error: (error, st) {
                  return Center(
                    child: Text(
                      error.toString(),
                    ),
                  );
                },
                // loading: () => const Loader(),
                loading: () => const Text('loadin'),
              ),

          // ================================================================================================
        ],
      ),
      
    );
  }
}
