import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

final String apiUrl =
    "https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/btc.json";

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();

  //function
  Future<void> convertCurrency() async {
    final userValue = double.tryParse(textEditingController.text);

    if (userValue == null) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid BTC value')),
        );
      });
      return;
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      double rate = data['btc']['inr'];

      setState(() {
        result = userValue * rate;
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(205, 193, 255, 1),
      appBar: AppBar(
        title: Text('Currency Converter BTC to INR'),
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Color.fromRGBO(205, 193, 255, 1),
        elevation: 0,
      ),
      // Scaffold: A basic page structure for Material Design apps.
      //Automatically provides space for an AppBar, body, floating action buttons, drawers, etc.
      body: Center(
        child: Column(
          // Column: Widgets ne vertically arrange kare
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "${result.toStringAsFixed(2)} INR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Color.fromRGBO(0, 0, 0, 1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontSize: 30,
                ),
                decoration: InputDecoration(
                  hintText: 'Please Enter BTC',
                  hintStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
                  prefixIcon: Icon(Icons.currency_bitcoin),
                  prefixIconColor: Color.fromRGBO(0, 0, 0, 0.498),
                  filled: true,
                  fillColor: Color.fromRGBO(245, 239, 255, 1),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                onPressed: convertCurrency,
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(165, 148, 249, 1),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text("Convert"),
              ),
            ),
          ], //children
        ),
      ),
    );
  }
}
