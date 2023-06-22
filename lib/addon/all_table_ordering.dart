import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ssrtab/addon/menumodel.dart';

class FoodMenuScreen extends StatefulWidget {
  String? order_id;
  FoodMenuScreen({super.key, this.order_id});

  @override
  _FoodMenuScreenState createState() => _FoodMenuScreenState();
}

class _FoodMenuScreenState extends State<FoodMenuScreen> {
  final List<MenuItem> _menuItems = [
    MenuItem(name: 'Burger', price: 5.99),
    MenuItem(name: 'Pizza', price: 8.99),
    MenuItem(name: 'Fries', price: 2.99),
    MenuItem(name: 'Salad', price: 4.99),
  ];

  final Map<String, int> _orderItems = {};

  late AsyncSnapshot<MenuModel> _snapshot; // Declare snapshot variable

  get order_id => null;
  Future<MenuModel> fetchAllData() async {
    final response =
        await http.get(Uri.parse('http://ssr.coderouting.com/getAllFoods'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      log("DATA $data");
      return MenuModel.fromJson(data);
    } else {
      return MenuModel.fromJson(data);
    }
  }

  double get totalAmount {
    return _menuItems.fold(0,
        (total, item) => total + (item.price * (_orderItems[item.name] ?? 0)));
  }

  Future<void> handleOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final orderId = prefs.getString("order_id");
    print(orderId);

    String orderDetails = _orderItems.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');

    final orderData = {
      'order_id': orderId,
      'order_details': orderDetails,
      'amount': totalAmount,
    };

    final response = await http.post(
      Uri.parse('http://ssr.coderouting.com}/UpdateOrderDetails'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(orderData),
    );

    print("here2");
    var jsonResponse = json.decode(response.body.toString());
    print(jsonResponse);
    print("here 3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Menu'),
      ),
      body: FutureBuilder(
        future: fetchAllData(),
        builder: (context, snapshot) {
          _snapshot = snapshot; // Assign the snapshot to the instance variable

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Expanded(
                  flex: 6,
                  child: ListView.builder(
                    itemCount: snapshot.data!.foods!.length,
                    itemBuilder: (context, index) {
                      final itemFromApi = snapshot.data!.foods![index];
                      final item = itemFromApi;
                      final itemName = itemFromApi.name!;
                      final itemCount = _orderItems[itemName] ?? 0;

                      return ListTile(
                        title: Text('${itemFromApi.name}  x $itemCount'),
                        subtitle: Text(itemFromApi.price.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _orderItems.update(
                                      itemName, (value) => value + 1,
                                      ifAbsent: () => 1);
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (itemCount > 1) {
                                    _orderItems.update(
                                        itemName, (value) => value - 1);
                                  } else {
                                    _orderItems.remove(itemName);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )),
              const Divider(),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    const Text('Order Summary',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _orderItems.length,
                        itemBuilder: (context, index) {
                          final itemName = _orderItems.keys.toList()[index];
                          final itemCount = _orderItems[itemName]!;
                          final itemPrice = _snapshot.data!.foods!
                              .firstWhere((item) => item.name == itemName)
                              .price;

                          return ListTile(
                            title: Text('$itemName x $itemCount'),
                            subtitle: Text(
                                '\$${(itemPrice! * itemCount).toStringAsFixed(2)}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _orderItems.remove(itemName);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total: \$${_snapshot.data!.foods!.fold(0, (total, item) => total + (item.price! * (_orderItems[item.name] ?? 0))).toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text('Place Order'),
                        onPressed: handleOrder,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;

  MenuItem({required this.name, required this.price});
}
