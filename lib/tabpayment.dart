import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ssrtab/paymentdone.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentOption;

  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expirationDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  void _selectPaymentOption(String? option) {
    setState(() {
      _selectedPaymentOption = option;
    });
  }

  Future<void> _submitPaymentForm() async {
    String cardHolderName = _cardHolderNameController.text;
    String cardNumber = _cardNumberController.text;
    String expirationDate = _expirationDateController.text;
    String cvv = _cvvController.text;
    print("submit");
    final respose =
        await http.post(Uri.parse("http://ssr.coderouting.com/Payment"),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              "card_number": cardNumber,
              "cvv": cvv,
              "expiration_date": expirationDate,
              "amount": cardHolderName
            }));
    print("here");

    // Perform the validations
    if (cardHolderName.isEmpty ||
        cardNumber.isEmpty ||
        expirationDate.isEmpty ||
        cvv.isEmpty) {
      // Show an error message if any of the fields are empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please fill in all the required fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (cardNumber.replaceAll(' ', '').length != 16) {
      // Show an error message if the card number length is not 16 digits
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter a 16-digit card number.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else if (cvv.length != 3) {
      // Show an error message if the CVV length is not 3 digits
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please enter a 3-digit CVV number.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (respose.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Payment Status'),
              content: const Text('Payment Successful'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
      // All validations passed, proceed with the payment submission logic
      // Submit the payment form
      // Handle the payment submission logic here
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Credit/Debit Card Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _cardHolderNameController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              maxLength: 16,
              decoration: const InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expirationDateController,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      labelText: 'Expiration Date (MM/YY)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPaymentForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const PaymentScreen(),
  ));
}
