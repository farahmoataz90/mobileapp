import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../DataBaseHelper.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  bool isFavorite = false; // Not implemented in Firestore helper; update as needed.
  bool isAddedToCart = false;
  int randomRating = Random().nextInt(5) + 1;

  @override
  void initState() {
    super.initState();
    _checkCartStatus();
  }

  Future<void> _checkCartStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _databaseHelper.getCartItems(user.uid).listen((cartItems) {
        final isInCart = cartItems.any((item) => item['id'] == widget.product['id']);
        setState(() {
          isAddedToCart = isInCart;
        });
      });
    }
  }

  Future<void> _toggleCartStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (isAddedToCart) {
        final cartItemsStream = _databaseHelper.getCartItems(user.uid);
        await cartItemsStream.first.then((cartItems) {
          final item = cartItems.firstWhere((item) => item['id'] == widget.product['id']);
          _databaseHelper.removeFromCart(user.uid, item['id']);
        });
      } else {
        _databaseHelper.addToCart(user.uid, widget.product);
      }
      setState(() {
        isAddedToCart = !isAddedToCart;
      });
    }
  }

  List<Widget> _generateStars() {
    return List<Widget>.generate(
      5,
      (i) => Icon(
        i < randomRating ? Icons.star : Icons.star_border,
        color: i < randomRating ? Colors.yellow : Colors.grey,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF22223B),
                  Color(0xff4A4E69),
                  Color(0xff9A8C98),
                  Color(0xffC9ADA7),
                  Color(0xffF2E9E4)
                ],
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Product Details'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                widget.product['category'],
                style: const TextStyle(fontSize: 16, color: Color(0xffc9ada7)),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.product['images'][0],
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.product['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : const Color(0xff22223b),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                widget.product['description'],
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${widget.product["price"]}',
                style: const TextStyle(fontSize: 18, color: Colors.green),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _generateStars(),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _toggleCartStatus,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isAddedToCart
                        ? Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : const Color(0xff22223b).withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(
                    isAddedToCart
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart,
                    color: isAddedToCart ? const Color(0xff22223b) : null,
                    size: 20,
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
