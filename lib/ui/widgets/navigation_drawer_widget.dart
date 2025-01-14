import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/screens/add_book_screen.dart';
import 'package:book_store_application/ui/screens/home_screen.dart';
import 'package:book_store_application/ui/screens/purchased_book_screen.dart';
import 'package:book_store_application/ui/screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          DrawerListItem(
            icon: Icons.shopping_cart_outlined,
            title: 'shoppingCart',
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => BookProvider()..getPurchasedBook(),
                    child: const ShoppingCartScreen(),
                  ),
                ),
              );
            },
          ),
          DrawerListItem(
            icon: Icons.fact_check_outlined,
            title: 'DoneBooks',
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => BookProvider()..getDoneBooks(),
                    child: const PurchasedBookScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
