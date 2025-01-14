import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/screens/home_screen.dart';
import 'package:book_store_application/ui/screens/purchased_book_screen.dart';
import 'package:book_store_application/ui/widgets/appbar_widget.dart';
import 'package:book_store_application/ui/widgets/shop_book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBarWidget(title: 'Shopping Cart'),
      body: SafeArea(
        child: Consumer<BookProvider>(
          builder: (context, shopBookProvider, child) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                ListView.builder(
                  itemCount: shopBookProvider.shopBookList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var shopBook = shopBookProvider.shopBookList[index];
                    return ShopBookListItem(
                        width: width,
                        shopBook: shopBook,
                        provider: shopBookProvider);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
