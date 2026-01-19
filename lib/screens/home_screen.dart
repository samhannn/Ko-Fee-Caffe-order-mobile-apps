import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_item.dart';
import '../widgets/home_drawer.dart';
import './cart_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrinkSelected = true;

  final List<Product> _drinks = [
    Product(id: '1', title: 'Americano', price: '10k', type: 'drink', imageUrl: 'assets/images/americano.png', description: 'Espresso shot topped with hot water. Bold & strong taste'),
    Product(id: '2', title: 'Cappucino', price: '15k', type: 'drink', imageUrl: 'assets/images/cappucino.png', description: 'Perfect balance of espresso, steamed milk and foam.'),
    Product(id: '3', title: 'Latte', price: '17k', type: 'drink', imageUrl: 'assets/images/latte.png', description: 'Smooth milky coffee with a thin layer of foam.'),
    Product(id: '4', title: 'Chocolate', price: '15k', type: 'drink', imageUrl: 'assets/images/chocolate.png', description: 'Sweet and creamy chocolate drink, perfect for mood booster.'),
    Product(id: '5', title: 'Matcha', price: '15k', type: 'drink', imageUrl: 'assets/images/matcha.png', description: 'Authentic Japanese green tea mixed with fresh milk.'),
  ];

  final List<Product> _foods = [
    Product(id: 'f1', title: 'steak', price: '35k', type: 'food', imageUrl: 'assets/images/steak.png', description: 'Juicy grilled steak served with special sauce.'),
    Product(id: 'f2', title: 'Burger', price: '35k', type: 'food', imageUrl: 'assets/images/hamburger.png', description: 'Classic beef burger with fresh lettuce and cheese.'),
    Product(id: 'f3', title: 'French Fries', price: '18k', type: 'food', imageUrl: 'assets/images/fries.png', description: 'Crispy golden fries, best snack companion.'),
    Product(id: 'f4', title: 'Pizza', price: '45k', type: 'food', imageUrl: 'assets/images/pizza.png', description: 'Tasty pizza with melted mozzarella and toppings.'),
    Product(id: 'f5', title: 'Ramen', price: '32k', type: 'food', imageUrl: 'assets/images/ramen.png', description: 'Hot savory noodle soup with egg and meat slices.'),
    Product(id: 'f6', title: 'Salad', price: '25k', type: 'food', imageUrl: 'assets/images/salad.png', description: 'Healthy mix of fresh vegetables and dressing.'),
    Product(id: 'f7', title: 'Dimsum', price: '25k', type: 'food', imageUrl: 'assets/images/dimas.png', description: 'Steamed dumplings with delicious chicken/shrimp filling.'),
    
  ];
  
  @override
  Widget build(BuildContext context) {
    final displayedProducts = isDrinkSelected ? _drinks : _foods;

    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black, size: 28),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: GestureDetector(
                // --- NAVIGASI KE LAYAR KERANJANG ---
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 30),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) => cart.itemCount > 0
                          ? Positioned(
                              right: -8,
                              top: -8,
                              child: Text(
                                '${cart.itemCount}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToggleButton("Drink", isDrinkSelected),
                const SizedBox(width: 10),
                _buildToggleButton("Food", !isDrinkSelected),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: displayedProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return ProductItem(product: displayedProducts[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() => isDrinkSelected = text == "Drink");
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}