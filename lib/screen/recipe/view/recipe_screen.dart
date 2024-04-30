import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reexam2/utils/fire_helper.dart';

import '../model/model.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  RecipeModel? model =Get.arguments;
  TextEditingController txtRecipe = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    if(model!=null){
      txtRecipe = TextEditingController(text: model!.recipe);
      txtQty = TextEditingController(text: model!.quantity);
      txtPrice = TextEditingController(text: model!.price);
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Your Fav Recipe",
            style: TextStyle(fontSize: 17),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: txtRecipe,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      };
                      return null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.fastfood),
                        border: OutlineInputBorder(),
                        hintText: "RecipeName"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    keyboardType: TextInputType.number,
                    controller: txtQty,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      };
                      return null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                        hintText: "Price"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(

                    keyboardType: TextInputType.number,
                    controller: txtPrice,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      };
                      return null;
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.add),
                        border: OutlineInputBorder(),
                        hintText: "Quantity"),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      // if (model.recipeId ==null) {
                      // FireDbHelper.fireDbHelper.update(model.recipeId!, txtRecipe.text, txtPrice.text, txtQty.text);
                      // }
                      if (_formKey.currentState!.validate()) {
                        RecipeModel p1 = RecipeModel(
                          recipe: txtRecipe.text,
                          quantity: txtQty.text,
                          price: txtPrice.text,
                        );
                        FireDbHelper.fireDbHelper.addData(p1);
                      }
                      Get.back();
                    },
                    child: Container(
                      height: MediaQuery
                          .sizeOf(context)
                          .height * 0.07,
                      width: MediaQuery
                          .sizeOf(context)
                          .width * 0.80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
