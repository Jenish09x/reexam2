import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reexam2/screen/bookmark/controller/bookmark_controller.dart';
import 'package:reexam2/screen/recipe/model/model.dart';
import 'package:reexam2/utils/fire_helper.dart';

import '../../../utils/db_helper.dart';
import '../../bookmark/model/bookmark_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BookmarkController controller = Get.put(BookmarkController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Veg Masala"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed("bookmark");
              },
              icon: const Icon(Icons.bookmark_add_outlined),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: FireDbHelper.fireDbHelper.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("${snapshot.hasData}");
            } else if (snapshot.hasData) {
              List<RecipeModel> recipeData = [];
              QuerySnapshot? qs = snapshot.data;
              if (qs != null) {
                List<QueryDocumentSnapshot> qsList = qs.docs;
                for (var x in qsList) {
                  Map m1 = x.data() as Map;
                  RecipeModel p1 = RecipeModel(
                    recipe: m1['recipe'],
                    quantity: m1['quantity'],
                    price: m1['price'],
                    recipeId: x.id,
                  );
                  recipeData.add(p1);
                }
              }
              return ListView.builder(
                itemCount: recipeData.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.sizeOf(context).height * 0.11,
                  width: MediaQuery.sizeOf(context).width * 0.80,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.fastfood,
                                color: Colors.white,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${recipeData[index].recipe}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "${recipeData[index].quantity}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "${recipeData[index].price}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.20,
                      ),
                      IconButton(
                        onPressed: () {
                          FireDbHelper.fireDbHelper
                              .delete(recipeData[0].recipeId);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                         Get.toNamed("recipe",arguments: recipeData[index]);
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          BookmarkModel save = BookmarkModel(
                            recipe: recipeData[index].recipe,
                            quantity: recipeData[index].quantity,
                            price: recipeData[index].price,
                          );
                          DbHelper.helper.addRecipe(save);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("recipe");
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
