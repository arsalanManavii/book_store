import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  BookDetailScreen({
    super.key,
    required this.id,
    required this.bookTitle,
    required this.bookDescription,
    required this.price,
  });
  final int id;
  final String bookTitle;
  final String bookDescription;
  final int price;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    var shopBookProvider = Provider.of<BookProvider>(context);
    int quantity = 0;
    return Scaffold(
      appBar: AppBarWidget(
        title: 'Book Detail',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: height / 4,
              child: Image.asset('assets/images/book.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Book Name :',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      '-${bookTitle.toUpperCase()}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Book Description :',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      bookDescription,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Book Price :',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Text(
                      '$price.00 T',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 50.0),
              child: ElevatedButton(
                onPressed: () async {
                  quantity = await shopBookProvider.getQuantityOfBook(id) ?? 0;
                  shopBookProvider.addBookToShoppingCart(id, ++quantity);
                },
                child: const Text('Add To shopCart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
