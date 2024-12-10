import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:sembast/sembast.dart';
// import 'package:sembast/sembast_io.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a product to the cart
  Future<void> addToCart(String userId, Map<String, dynamic> product) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .add(product);
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }

  // Get the user's cart items
  Stream<List<Map<String, dynamic>>> getCartItems(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList());
  }

  // Remove an item from the cart
  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception('Error removing from cart: $e');
    }
  }

  // Clear the cart
  Future<void> clearCart(String userId) async {
    try {
      final cartItems = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();
      for (var doc in cartItems.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception('Error clearing cart: $e');
    }
  }

   // Get user's favorite items
  Stream<List<Map<String, dynamic>>> getUserFavorites(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => doc.data()..['id'] = doc.id).toList());
  }
  // Delete a favorite item
  Future<void> deleteFavorite(String userId, String favoriteId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .doc(favoriteId)
          .delete();
    } catch (e) {
      throw Exception('Error removing favorite: $e');
    }
  }
}
