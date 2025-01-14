import 'package:book_store_application/model/book_model.dart';
import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/screens/book_detail_screen.dart';
import 'package:book_store_application/ui/screens/home_screen.dart';
import 'package:book_store_application/ui/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key, required this.provider});
  final BookProvider provider;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      appBar: AppBarWidget(title: 'Search'), 
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: TextField(
                controller: searchController,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'search here ...',
                  hintStyle:
                      Theme.of(context).textTheme.bodyMedium,
                  filled: Theme.of(context).inputDecorationTheme.filled,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  enabledBorder:
                      Theme.of(context).inputDecorationTheme.enabledBorder,
                  focusedBorder:
                      Theme.of(context).inputDecorationTheme.focusedBorder,
                ),
                onSubmitted: (value) {
                  provider.searchedBooks(value);
                },
              ),
            ),
          ),
          Consumer<BookProvider>(
            builder: (context, searchProvider, child) {
              return SliverList.builder(
                itemCount: searchProvider.searchBookList.length,
                itemBuilder: (context, index) {
                  BookModel book = searchProvider.searchBookList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider.value(
                            value: searchProvider,
                            child: BookDetailScreen(
                              id: book.id!,
                              bookTitle: book.bookName!,
                              bookDescription: book.bookDescription!,
                              price: book.bookPrice!,
                            ),
                          ),
                        ),
                      );
                    },
                    child: BookListItem(
                        width: width, book: book, provider: searchProvider),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
