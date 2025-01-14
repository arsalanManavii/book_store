import 'package:book_store_application/model/book_model.dart';
import 'package:book_store_application/state_managment/book_provider.dart';
import 'package:book_store_application/ui/widgets/appbar_widget.dart';
import 'package:book_store_application/ui/widgets/textfield_widget.dart';
import 'package:book_store_application/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddBookScreen extends StatelessWidget {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController bookNameController = TextEditingController();
    TextEditingController bookDescriptionController = TextEditingController();
    TextEditingController bookPriceController = TextEditingController();
    var provider = Provider.of<BookProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String validationText = Utils.validation(
            bookNameController.text,
            bookDescriptionController.text,
            bookPriceController.text.isEmpty
                ? -1
                : int.parse(
                    bookPriceController.text,
                  ),
          );
          if (validationText.isEmpty) {
            BookModel book = BookModel(
              bookName: bookNameController.text,
              bookDescription: bookDescriptionController.text,
              bookPrice: bookPriceController.text.isEmpty
                  ? 0
                  : int.parse(
                      bookPriceController.text,
                    ),
            );
            provider.addBook(book);
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(validationText),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBarWidget(title: 'ADD Book'),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextfieldWidget(
              TextInputType.text,
              title: 'Book Name',
              controller: bookNameController,
              icon: const Icon(Icons.edit),
              inputFormatters: const [],
            ),
            const SizedBox(height: 30.0),
            TextfieldWidget(
              TextInputType.text,
              title: 'Book Description',
              controller: bookDescriptionController,
              icon: const Icon(Icons.description),
              inputFormatters: const [],
            ),
            const SizedBox(height: 30.0),
            TextfieldWidget(
              const TextInputType.numberWithOptions(decimal: false),
              title: 'Book Price',
              controller: bookPriceController,
              icon: const Icon(Icons.euro),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^(0|[1-9]\d*)(\.\d{0,2})?$'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
