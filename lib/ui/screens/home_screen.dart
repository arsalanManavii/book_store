import 'package:book_store_application/helper/shared_preferences.dart';
import 'package:book_store_application/model/book_model.dart';
import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/state_managment/theme_provider.dart';
import 'package:book_store_application/ui/screens/add_book_screen.dart';
import 'package:book_store_application/ui/screens/book_detail_screen.dart';
import 'package:book_store_application/ui/screens/search_screen.dart';
import 'package:book_store_application/ui/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var provider = Provider.of<BookProvider>(context);
    var switchIcon = (Preferences.isDarkTheme)
        ? const Icon(Icons.light_mode_outlined)
        : const Icon(Icons.dark_mode);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => BookProvider(),
                child: const AddBookScreen(),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
      drawer: const Drawer(
        child: NavigationDrawerWidget(),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.toggleTheme();
            },
            icon: switchIcon,
          ),
          IconButton(
            onPressed: () {
              provider.clearSearchList();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: provider,
                    child: SearchScreen(
                      provider: provider,
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, child) {
          bookProvider.books();

          return ListView.builder(
            itemCount: bookProvider.bookList.length,
            itemBuilder: (BuildContext context, int index) {
              var book = bookProvider.bookList[index];
              return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => BookProvider(),
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
                      width: width, book: book, provider: bookProvider));
            },
          );
        },
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  const BookListItem({
    super.key,
    required this.width,
    required this.book,
    required this.provider,
  });

  final double width;
  final BookModel book;
  final BookProvider provider;

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
                    book.bookName!,
                    style: Theme.of(context).textTheme.labelLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 5.0),
                SizedBox(
                  width: width / 4,
                  child: Text(
                    book.bookDescription!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            '${book.bookPrice}.0 T',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          IconButton(
            onPressed: () {
              provider.deleteBook(book);
              provider.books();
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class DrawerListItem extends StatelessWidget {
  const DrawerListItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
