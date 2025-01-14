import 'package:book_store_application/model/book_model.dart';
import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:flutter/material.dart';

class ShopBookListItem extends StatelessWidget {
  ShopBookListItem({
    super.key,
    required this.width,
    required this.shopBook,
    required this.provider,
  });

  final double width;
  final BookModel shopBook;
  final BookProvider provider;

  @override
  Widget build(BuildContext context) {
    var totalPrice = (shopBook.quantity! * shopBook.bookPrice!);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: width,
      child: Row(
        children: [
          SizedBox(
              width: 60.0,
              height: 60.0,
              child: Image.asset('assets/images/book.png', fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width / 4,
                  child: Text(
                    shopBook.bookName!,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '${shopBook.quantity!}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '$totalPrice.0 T',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          IconButton(
            onPressed: () {
              provider.deleteFromShoppingBag(shopBook.id!);
              provider.getPurchasedBook();
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            color: Colors.green,
            onPressed: () {
              provider.addBooksToDone(shopBook.id!);
              provider.deleteFromShoppingBag(shopBook.id!);
              provider.getPurchasedBook();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
