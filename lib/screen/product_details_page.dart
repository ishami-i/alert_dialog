import 'package:flutter/material.dart';
import '../module/product.dart';
import '../widget/product_image.dart';
import '../widget/rating_stars.dart';
import '../widget/alertdialog.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    // The AppBar automatically shows a back button that pops to the list page.
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Column(
        children: [
          ProductImage(
            product: product,
            width: double.infinity,
            height: 250,
            fontSize: 64,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  Text(product.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  Text('Price: ${product.price}',
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 20),
                  RatingStars(
                    rating: product.rating,
                    size: 24,
                    alignment: MainAxisAlignment.end,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteConfirmDialog(
                          productName: product.name,
                          onConfirm: () {
                            onDelete(); // Remove item from the page state list
                            Navigator.of(context).pop(); // Close dialog
                            Navigator.of(context).popUntil((route) => route.isFirst); // Go back to main page
                          },
                        ),
                        barrierDismissible: false,
                      );
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
