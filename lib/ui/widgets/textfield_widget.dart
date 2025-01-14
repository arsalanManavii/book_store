import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldWidget extends StatelessWidget {
  TextfieldWidget(
    this.textInputType, {
    super.key,
    required this.title,
    required this.controller,
    required this.icon,
    required this.inputFormatters,
  });

  final String title;
  final TextEditingController controller;
  final Widget icon;
  final TextInputType textInputType;
  final List<TextInputFormatter> inputFormatters;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        label: Text(title),
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            width: 1.0,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
