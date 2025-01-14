import 'package:book_store_application/helper/database_helper.dart';

class BookModel {
  int? id;
  String? bookName;
  String? bookDescription;
  int? bookPrice;
  int? quantity;
  bool? isAddedToBasket;
  bool? isAddedToDone;

  BookModel({
    this.id,
    this.bookName,
    this.bookDescription,
    this.bookPrice,
    this.quantity = 0,
    this.isAddedToBasket = false,
    this.isAddedToDone = false,
  });

  Map<String, Object?> toMap() {
    return {
      DatabaseHelper.bookColumnId: id,
      DatabaseHelper.bookColumnName: bookName,
      DatabaseHelper.bookColumnDescription: bookDescription,
      DatabaseHelper.bookColumnPrice: bookPrice,
      DatabaseHelper.bookColumnQuantity: quantity,
      DatabaseHelper.bookColumnIsAddedToBasket: isAddedToBasket! ? 1 : 0,
      DatabaseHelper.bookColumnIsAddedToDone: isAddedToDone! ? 1 : 0,
    };
  }

  BookModel copy({
    int? id,
    String? bookName,
    String? bookDescription,
    int? bookPrice,
    int? quantity,
    bool? isAddedToBasket,
    bool? isAddedToDone,
  }) =>
      BookModel(
        id: id ?? this.id,
        bookName: bookName ?? this.bookName,
        bookDescription: bookDescription ?? this.bookDescription,
        bookPrice: bookPrice ?? this.bookPrice,
        quantity: quantity ?? this.quantity,
        isAddedToBasket: isAddedToBasket ?? this.isAddedToBasket,
        isAddedToDone: isAddedToDone ?? this.isAddedToDone,
      );

  factory BookModel.fromMap(Map<String, Object?> fromMap) {
    return BookModel(
      id: fromMap[DatabaseHelper.bookColumnId] as int,
      bookName: fromMap[DatabaseHelper.bookColumnName] as String,
      bookDescription: fromMap[DatabaseHelper.bookColumnDescription] as String,
      bookPrice: fromMap[DatabaseHelper.bookColumnPrice] as int,
      quantity: fromMap[DatabaseHelper.bookColumnQuantity] as dynamic,
      isAddedToBasket: fromMap[DatabaseHelper.bookColumnIsAddedToBasket] == 1,
      isAddedToDone: fromMap[DatabaseHelper.bookColumnIsAddedToDone] == 1,
    );
  }
}
