import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import './receipt_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartKeys = cart.items.keys.toList();
    final cartValues = cart.items.values.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Cart Order",
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: cart.items.isEmpty
                ? const Center(child: Text("Your basket feels light", style: TextStyle(fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      String productId = cartKeys[i];
                      CartItem item = cartValues[i];

                      bool isWideScreen = MediaQuery.of(context).size.width > 380;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: ClipOval(
                                           child: item.imageUrl.startsWith('http')
                                            ? Image.network(
                                                item.imageUrl,
                                                width: 40, height: 40, fit: BoxFit.cover,
                                                errorBuilder: (c, o, s) => const Icon(Icons.coffee, color: Colors.brown),
                                              )
                                            : Image.asset(
                                                item.imageUrl,
                                                width: 40, height: 40, fit: BoxFit.cover,
                                                errorBuilder: (c, o, s) => const Icon(Icons.coffee, color: Colors.brown),
                                              ),
                                           ),
                                        ),
                                      ),
                                      
                                      const SizedBox(width: 12),

                                      Expanded(
                                        child: isWideScreen
                                            ?
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      item.title,
                                                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    "Rp ${item.price}",
                                                    style: TextStyle(color: Colors.grey[300], fontSize: 13),
                                                  ),
                                                ],
                                              )
                                            :
                                            Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.title,
                                                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    "Rp ${item.price}",
                                                    style: TextStyle(color: Colors.grey[300], fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                      ),

                                      const SizedBox(width: 8),

                                      Row(
                                        children: [
                                          _buildQtyBtn(
                                            icon: Icons.remove, 
                                            onTap: () => cart.removeSingleItem(productId)
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              "${item.quantity}",
                                              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          _buildQtyBtn(
                                            icon: Icons.add, 
                                            onTap: () => cart.addItem(productId, item.title, item.price, item.imageUrl)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 10),

                              GestureDetector(
                                onTap: () => cart.removeItem(productId),
                                child: Container(
                                  width: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.delete_outline, color: Colors.white, size: 24),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          if (cart.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Price : Rp ${cart.totalAmount.toStringAsFixed(0)}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        final currentItems = cart.items.values.toList();
                        final currentTotal = cart.totalAmount;

                        cart.clear();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReceiptScreen(
                              purchasedItems: currentItems,
                              totalAmount: currentTotal,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 22, height: 22,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: Colors.white, size: 14),
    ),
  );
}