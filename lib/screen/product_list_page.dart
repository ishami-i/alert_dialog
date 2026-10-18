import 'package:flutter/material.dart';
import '../module/product.dart';
import '../widget/product_image.dart';
import '../widget/rating_stars.dart';
import '../screen/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // Local UI list state initialized from Product.sample (the database),
  // so deletions remove items on the page without modifying the database.
  late final List<Product> _products = List.from(Product.sample);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Navigation')),
      body: _products.isEmpty
          ? const Center(child: Text('No products available'))
          : ListView.builder(
              padding: const EdgeInsets.all(2),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return _ProductItem(
                  product: product,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(
                          product: product,
                          onDelete: () {
                            setState(() {
                              _products.removeAt(index);
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class _ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const _ProductItem({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: ProductImage(product: product, height: double.infinity),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 11),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text('Price: ${product.price}',
                          style: const TextStyle(fontSize: 11)),
                      const SizedBox(height: 4),
                      RatingStars(
                        rating: product.rating,
                        size: 18,
                        alignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
