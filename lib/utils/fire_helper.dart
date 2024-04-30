import 'package:cloud_firestore/cloud_firestore.dart';

import '../screen/recipe/model/model.dart';

class FireDbHelper {
  static FireDbHelper fireDbHelper = FireDbHelper._();

  FireDbHelper._();

  FirebaseFirestore fireDb = FirebaseFirestore.instance;

  RecipeModel recipeModel = RecipeModel();

  Future<void> addData(RecipeModel r1) async {
    await fireDb.collection("recipe").add(
      {
        "recipe": r1.recipe,
        "quantity": r1.quantity,
        "price": r1.price,
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() {
    return fireDb.collection("recipe").snapshots();
  }

  void delete(String? recipeId) async {
    await fireDb
        .collection("recipe")
        .doc(recipeId)
        .delete();
  }

  void update(String recipeId, String recipe, String price,String quantity) async {
    await fireDb.collection("recipe").doc(recipeId).update({
      "recipe": recipe,
      "price": price,
      "quantity":quantity,
    });
  }
}
