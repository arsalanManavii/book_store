import 'package:book_store_application/helper/database_helper.dart';
import 'package:book_store_application/model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class BookProvider extends ChangeNotifier {
  List<BookModel> _bookList = [];
  List<BookModel> _shopBookList = [];
  List<BookModel> _doneBookList = [];
  List<BookModel> _searchBookList = [];
  void addBook(BookModel book) async {
    final db = await DatabaseHelper.instance.database;
    final id = await db.insert(
      DatabaseHelper.bookTable,
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    book.copy(id: id);
    notifyListeners();
  }

  void addBookToShoppingCart(
    int id,
    int? quantity,
  ) async {
    var db = await DatabaseHelper.instance.database;
    if (quantity != null) {
      await db.update(
          DatabaseHelper.bookTable,
          {
            DatabaseHelper.bookColumnIsAddedToBasket: 1,
            DatabaseHelper.bookColumnQuantity: quantity,
          },
          where: '${DatabaseHelper.bookColumnId} = ?',
          whereArgs: [id]);
      notifyListeners();
    } else {
      await db.update(
          DatabaseHelper.bookTable,
          {
            DatabaseHelper.bookColumnIsAddedToBasket: 1,
            DatabaseHelper.bookColumnQuantity: 1,
          },
          where: '${DatabaseHelper.bookColumnId} = ?',
          whereArgs: [id]);
      notifyListeners();
    }
  }

  void deleteFromShoppingBag(int id) async {
    var db = await DatabaseHelper.instance.database;
    await db.update(
      DatabaseHelper.bookTable,
      {
        DatabaseHelper.bookColumnIsAddedToBasket: 0,
        DatabaseHelper.bookColumnQuantity: 0,
      },
      where: '${DatabaseHelper.bookColumnId} = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<int?> getQuantityOfBook(int id) async {
    var db = await DatabaseHelper.instance.database;
    var result = await db.query(
      DatabaseHelper.bookTable,
      columns: [
        '${DatabaseHelper.bookColumnQuantity}',
      ],
      where: '${DatabaseHelper.bookColumnId} = ?',
      whereArgs: [id],
    );
    print(result);
    if (result.isNotEmpty) {
      return result.first[DatabaseHelper.bookColumnQuantity] as dynamic;
    } else {
      return 0; // Default to 0 if the book is not found
    }
  }

  void getPurchasedBook() async {
    var db = await DatabaseHelper.instance.database;
    var shopListMap = await db.query(
      DatabaseHelper.bookTable,
      where: '${DatabaseHelper.bookColumnIsAddedToBasket} = ?',
      whereArgs: [1],
    );
    List<BookModel> shopBookList =
        shopListMap.map((fromMap) => BookModel.fromMap(fromMap)).toList();
    _shopBookList = shopBookList;
    notifyListeners();
  }

  void addBooksToDone(int id) async {
    var db = await DatabaseHelper.instance.database;
    await db.update(
      DatabaseHelper.bookTable,
      {
        DatabaseHelper.bookColumnIsAddedToDone: 1,
      },
      where: '${DatabaseHelper.bookColumnId} = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  void getDoneBooks() async {
    var db = await DatabaseHelper.instance.database;
    var doneBookMap = await db.query(
      DatabaseHelper.bookTable,
      where: '${DatabaseHelper.bookColumnIsAddedToDone} = ?',
      whereArgs: [1],
    );
    List<BookModel> doneBookList =
        doneBookMap.map((fromMap) => BookModel.fromMap(fromMap)).toList();
    _doneBookList = doneBookList;
    notifyListeners();
  }

  void deleteBook(BookModel book) async {
    var db = await DatabaseHelper.instance.database;
    await db.delete(
      DatabaseHelper.bookTable,
      where: '${DatabaseHelper.bookColumnId} = ?',
      whereArgs: [book.id],
    );
    notifyListeners();
  }

  void searchedBooks(String searchQuery) {
    searchBookList.clear();
    _searchBookList.addAll(
      bookList.where(
        (book) =>
            book.bookName!.toLowerCase().contains(searchQuery.toLowerCase()),
      ),
    );

    notifyListeners();
  }

  void clearSearchList() {
    _searchBookList.clear();
    notifyListeners();
  }

  // void addBookToShoppingCart(ShopBookModel shopBook) async {
  //   final db = await DatabaseHelper.instance.database;
  //   final id = await db.insert(
  //     DatabaseHelper.shopBookTable,
  //     shopBook.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  //   shopBook.copy(id: id);
  //   notifyListeners();
  // }

  void books() async {
    final db = await DatabaseHelper.instance.database;
    var bookMap = await db.query(DatabaseHelper.bookTable);
    List<BookModel> bookList =
        bookMap.map((fromMap) => BookModel.fromMap(fromMap)).toList();
    _bookList = bookList;
    notifyListeners();
  }

  // void shopBooks() async {
  //   final db = await DatabaseHelper.instance.database;
  //   var shopBookMap = await db.query(DatabaseHelper.shopBookTable);
  //   List<ShopBookModel> shopBookList =
  //       shopBookMap.map((fromMap) => ShopBookModel.fromMap(fromMap)).toList();
  //   _shopBookList = shopBookList;
  //   notifyListeners();
  // }

  List<BookModel> get bookList => _bookList;
  List<BookModel> get shopBookList => _shopBookList;
  List<BookModel> get doneBookList => _doneBookList;
  List<BookModel> get searchBookList => _searchBookList;
  // List<ShopBookModel> get shopBookList => _shopBookList;
}
