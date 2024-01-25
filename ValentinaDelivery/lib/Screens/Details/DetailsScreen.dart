// ignore: file_names
import 'package:flutter/material.dart';

import '../Checkout/CheckoutScreen.dart';
import '../Class/CartItem.dart';
import '../Class/CartManager.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> itemDetails;

  const DetailsScreen({super.key, required this.itemDetails});

  @override
  // ignore: library_private_types_in_public_api
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int itemCount = 0;
  int countValid = 0;

  @override
  void initState() {
    super.initState();
    

    countValid = widget.itemDetails['rating']['count'] ?? 0;
  }

  void _incrementCount() {
    setState(() {
      itemCount++;
    });
  }

  void _decrementCount() {
    if (itemCount > 0) {
      setState(() {
        itemCount--;
      });
    }
  }

  void addItem(String title, String image, dynamic price, int quantity) {
    double finalPrice = price is int ? price.toDouble() : price;
    CartItem newItem = CartItem(
      title: title,
      image: image,
      price: finalPrice,
      quantity: quantity,
    );

    CartManager().addItemToCart(newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemDetails['title'] ?? 'Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.itemDetails['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            Center(
              child: Image.network(
                widget.itemDetails['image'],
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Price: \$${widget.itemDetails['price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  _buildStarRating(widget.itemDetails['rating'] ?? {}),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.itemDetails['description'] ?? '',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (countValid > 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: _decrementCount,
                    ),
                    const SizedBox(width: 8),
                    Text('$itemCount', style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                      onPressed: _incrementCount,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      addItem(widget.itemDetails['title'], widget.itemDetails['image'], widget.itemDetails['price'], itemCount);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CheckoutScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ),
            ] else ...[
              const Center(
                child: Text(
                  'Sold Out',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating(Map<String, dynamic> ratingData) {
    double rating = ratingData['rate'] ?? 0.0;
    int fullStars = rating.floor();
    bool hasHalfStar = rating - fullStars > 0;
    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (index == fullStars && hasHalfStar) {
          return const Icon(Icons.star_half, color: Colors.amber);
        }
        return const Icon(Icons.star_border, color: Colors.amber);
      }),
    );
  }
}
