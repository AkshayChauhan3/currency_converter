import 'package:flutter/material.dart';
import 'currency_converter_material_page.dart';

void main() {
  runApp(const MyApp());
}

// everything you see on the screen is a widget

class MyApp extends StatelessWidget {
  // StatelessWidget: widget don't change after it's build
  // it means it's like poster or something something static

  const MyApp({super.key});
  // super.key give the unique if of widgets to the parent class

  @override
  // we are overriding here the build method of StatelessWidget
  Widget build(BuildContext context) {
    // every widget must define build method to describe how it will look
    // BuildContext context: gives information about where this widget is in the widget tree

    return MaterialApp(home: CurrencyConverterMaterialPage());
    // MaterialApp: by this we can use Material design structure
  }
}
