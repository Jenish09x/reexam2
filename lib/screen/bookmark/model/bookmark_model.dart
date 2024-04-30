class BookmarkModel {
  int? id;
  String? recipe,quantity,price;

  BookmarkModel({this.id, required this.price, required this.recipe,required this.quantity});

  factory BookmarkModel.mapToModel(Map m1){
    return BookmarkModel(
      id: m1['id'],
      recipe: m1['recipe'],
      quantity: m1['Quantity'],
      price: m1['price'],
    );
  }
}
