import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  void _showProductDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),

        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 70,
            horizontal: 30
          ),
          
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Hero(
                  tag: product.id,
                  child: product.imageUrl.startsWith('http')
                      ? Image.network(product.imageUrl, fit: BoxFit.contain)
                      : Image.asset(product.imageUrl, fit: BoxFit.contain),
                ),
              ),

              const SizedBox(height: 50),

              Text(
                product.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 0.5,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                product.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.5,
                  color: Colors.grey[600]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => _showProductDetail(context),
                      child: Hero(
                        tag: product.id,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: ClipOval(
                            child: product.imageUrl.startsWith('http')
                                ? Image.network(product.imageUrl, fit: BoxFit.cover)
                                : Image.asset(product.imageUrl, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF444444),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.price,
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    product.title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: double.infinity, height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        int priceInt = int.tryParse(product.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
                        if (product.price.contains('k')) priceInt *= 1000;
                        Provider.of<CartProvider>(context, listen: false).addItem(
                          product.id, product.title, priceInt, product.imageUrl
                        );
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Item added!'), duration: Duration(milliseconds: 500))
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5F5F5F),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text('Add to cart', style: TextStyle(fontSize: 12)),
                    ),
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