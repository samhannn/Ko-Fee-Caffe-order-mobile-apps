import 'package:flutter/material.dart';
import 'dart:math';
import '../providers/cart_provider.dart';
import 'home_screen.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ReceiptScreen extends StatelessWidget {
  final List<CartItem> purchasedItems;
  final double totalAmount;

  const ReceiptScreen({
    super.key,
    required this.purchasedItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateStr = "${now.day}/${now.month}/${now.year}";
    final timeStr = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    final orderId = "ORD${Random().nextInt(90000) + 10000}";

    String formatCurrency(num price) {
      return "Rp ${(price / 1000).toStringAsFixed(3)}";
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              height: 60,
                              fit: BoxFit.contain,
                              errorBuilder: (ctx, error, stackTrace) => const Icon(Icons.coffee, size: 50), // Cadangan jika gambar tidak terbaca
                            ),
                            const Text(
                              "Ko-Fee", 
                              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: 1),
                            ),
                            const SizedBox(height: 5),
                            Text("Jl. Malioboro No. 17, Yogyakarta, Special Region Yogyakarta", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                            Text("Telp: 0812-9237-2174", style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      const Divider(color: Colors.black, thickness: 2, height: 2),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No Order\nDate\nTime", style: TextStyle(color: Colors.grey[700], height: 1.5)),
                          Text("$orderId\n$dateStr\n$timeStr", textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          )
                        ),
                        child: const Row(
                          children: [
                            Expanded(flex: 4, child: Text("ITEM", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                            Expanded(flex: 1, child: Text("QTY", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text("TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.right)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...purchasedItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                    Text("@ ${formatCurrency(item.price)}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1, 
                                child: Text("${item.quantity}x", style: const TextStyle(fontSize: 14), textAlign: TextAlign.center)
                              ),
                              Expanded(
                                flex: 2, 
                                child: Text(
                                  formatCurrency(item.price * item.quantity), 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), 
                                  textAlign: TextAlign.right
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 15),
                      const Divider(color: Colors.black, thickness: 2),
                      const SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("GRAND TOTAL", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(
                            formatCurrency(totalAmount),
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Center(
                        child: Column(
                          children: [
                            Text("Thank you for your order!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800])),
                            const SizedBox(height: 5),
                            Text("Always a pleasure to serve you", textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            const SizedBox(height: 20),
                            BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: orderId,
                              width: 200,
                              height: 60,
                              drawText: false,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}