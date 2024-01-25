// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../Class/CartItem.dart';
import '../Class/CartManager.dart';

class ReceiptScreen extends StatelessWidget {
  final double totalPrice;

  const ReceiptScreen({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    List<CartItem> purchasedItems = CartManager().cartItems;

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Valentina Delivery',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(),
              Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
              const Divider(),
              const Text(
                'Items Purchased:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                ),
              ),
              ...purchasedItems.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  "${item.title} x${item.quantity}",
                  style: const TextStyle(fontFamily: 'RobotoMono'),
                ),
              )).toList(),
              const Divider(),
              const Text(
                'Thank you for your purchase!',
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
