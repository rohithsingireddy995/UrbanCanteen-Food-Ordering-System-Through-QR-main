import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodItemList extends StatefulWidget {
  @override
  _FoodItemListState createState() => _FoodItemListState();
}

class _FoodItemListState extends State<FoodItemList> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Canteen Staff'),
        backgroundColor: Colors.green,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Pending'),
            Tab(text: 'Preparing'),
            Tab(text: 'Prepared'),
            Tab(text: 'Picked Up'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderList(status: 'Pending'),
          OrderList(status: 'Preparing'),
          OrderList(status: 'Prepared'),
          OrderList(status: 'Picked Up'),
        ],
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final String status;
  OrderList({required this.status});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('new_orders')
          .where('status', isEqualTo: status)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final orders = snapshot.data!.docs;
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text('Order ID: ${order['orderId']}'),
              subtitle: Text('Customer: ${order['customerName']}'),
              trailing: Text(status),
            );
          },
        );
      },
    );
  }
}
