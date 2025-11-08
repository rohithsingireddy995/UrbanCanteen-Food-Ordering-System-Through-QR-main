import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/food_item.dart';

class SuccessScreen extends StatelessWidget {
  final String transactionId;
  final List<FoodItem> cart;
  final double totalAmount;

  const SuccessScreen({
    required this.transactionId,
    required this.cart,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Successful')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Thank you for your order!'),
            SizedBox(height: 20),
            QrImageView(
              data: transactionId,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text('Show this QR code to collect your food.'),
          ],
        ),
      ),
    );
  }
}
