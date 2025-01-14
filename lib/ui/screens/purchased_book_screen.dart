import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/widgets/appbar_widget.dart';
import 'package:book_store_application/ui/widgets/done_book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchasedBookScreen extends StatelessWidget {
  const PurchasedBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBarWidget(title: 'Purchased Books'),
      body: SafeArea(
        child: Consumer<BookProvider>(
          builder: (context, doneBooks, child) {
            return ListView.builder(
              itemCount: doneBooks.doneBookList.length,
              itemBuilder: (BuildContext context, int index) {
                var doneBook = doneBooks.doneBookList[index];
                return DoneBookListItem(width: width, doneBook: doneBook);
              },
            );
          },
        ),
      ),
    );
  }
}
