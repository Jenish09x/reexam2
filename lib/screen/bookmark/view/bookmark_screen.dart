import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:reexam2/screen/bookmark/controller/bookmark_controller.dart';

import '../../../utils/db_helper.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  BookmarkController bookmarkController = Get.put(BookmarkController());

  @override
  void initState() {
    super.initState();
    bookmarkController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Saved Food"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: bookmarkController.favList.length,
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
                        const Icon(Icons.fastfood,color: Colors.white,size: 20,),
                        const SizedBox(width: 10,),
                        Text(
                          "${bookmarkController.favList[index].recipe}",
                          style: const TextStyle(color: Colors.white,fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.add,color: Colors.white,size: 20,),
                        Text(
                          "${bookmarkController.favList[index].quantity}",
                          style: const TextStyle(color: Colors.white,fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.attach_money,color: Colors.white,size: 20,),
                        Text(
                          "${bookmarkController.favList[index].price}",
                          style: const TextStyle(color: Colors.white,fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    DbHelper.helper.deleteRecipe(id: "${bookmarkController.favList[index].id}");
                    bookmarkController.getData();
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
