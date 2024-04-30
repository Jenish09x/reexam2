import 'package:get/get.dart';
import 'package:reexam2/screen/bookmark/model/bookmark_model.dart';

import '../../../utils/db_helper.dart';

class BookmarkController extends GetxController{
  RxList<BookmarkModel> favList = <BookmarkModel>[].obs;

  Future<void>getData()async{
    List<BookmarkModel> like = await DbHelper.helper.getRecipe();
    favList.value = like;
  }
}