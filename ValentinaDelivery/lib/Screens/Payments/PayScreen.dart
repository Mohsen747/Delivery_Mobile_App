// ignore: file_names
import 'package:flutter/material.dart';

import 'ReceiptScreen.dart';

class PayScreen extends StatefulWidget {
  final double totalPrice;

  PayScreen({required this.totalPrice});

  @override
  _PayScreenState createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final TextEditingController _monthYearController = TextEditingController();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _monthYearController.addListener(_formatMonthYear);
  }

  void _formatMonthYear() {
    String text = _monthYearController.text;
    if (text.length == 2 && !text.contains('/')) {
      _monthYearController.text = '$text/';
      _monthYearController.selection = TextSelection.fromPosition(TextPosition(offset: _monthYearController.text.length));
    }
  }

  @override
  void dispose() {
    _monthYearController.removeListener(_formatMonthYear);
    _monthYearController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _firstnameController,
                decoration: const InputDecoration(
                  labelText: 'Firstname',
                  hintText: 'Alex',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _lastnameController,
                decoration: const InputDecoration(
                  labelText: 'Lastname',
                  hintText: 'Jolig',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  hintText: '123 Main St, City, Country',
                  border: OutlineInputBorder(),
                ),
                minLines: 4,
                maxLines: 7,
              ),
              const SizedBox(height: 20),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text('Payment Info'),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Credit Card Number',
                  hintText: '1234 5678 9012 3456',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _monthYearController,
                      decoration: const InputDecoration(
                        labelText: 'Month/Year',
                        hintText: 'MM/YY',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.date_range),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'CVV2',
                        hintText: '123',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReceiptScreen(totalPrice: widget.totalPrice, firstName: _firstnameController.text,lastName: _lastnameController.text, address: _addressController.text,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Pay \$${widget.totalPrice.toStringAsFixed(2)}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
