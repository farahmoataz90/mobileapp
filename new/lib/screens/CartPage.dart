import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../DataBaseHelper.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Stream<List<Map<String, dynamic>>> cartStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      cartStream = DatabaseHelper().getCartItems(user.uid);
    }
  }

  void _removeCartItem(String itemId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await DatabaseHelper().removeFromCart(user.uid, itemId);
    }
  }

  double calculateTotalPrice(List<Map<String, dynamic>> cartItems) {
    double totalPrice = 0.0;
    for (final cartItem in cartItems) {
      totalPrice += cartItem['price'] ?? 0.0;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF22223B),
                Color(0xff4A4E69),
                Color(0xff9A8C98),
                Color(0xffC9ADA7),
                Color(0xffF2E9E4),
              ],
            ),
          ),
        ),
        title: Text('Cart'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: cartStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Your cart is empty.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final cartItems = snapshot.data!;
          final totalPrice = calculateTotalPrice(cartItems);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return ListTile(
                      // leading: Image.network(cartItem['image']),
                      title: Text(cartItem['title']),
                      subtitle: Text('\$${cartItem['price']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeCartItem(cartItem['id']);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Checkout Confirmation'),
                          content: Text(
                              'Are you sure you want to proceed with the checkout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Add your checkout logic here
                              },
                              child: Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
