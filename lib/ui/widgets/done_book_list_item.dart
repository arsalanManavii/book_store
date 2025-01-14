import 'package:book_store_application/model/book_model.dart';
import 'package:flutter/material.dart';

class DoneBookListItem extends StatelessWidget {
  DoneBookListItem({
    super.key,
    required this.width,
    required this.doneBook,
  });
  final double width;
  final BookModel doneBook;
  @override
  Widget build(BuildContext context) {
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
                    doneBook.bookName!,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: width / 2,
                  child: Text(
                    doneBook.bookDescription!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '${doneBook.bookPrice}.0 T',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
