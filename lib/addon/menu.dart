import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:ssrtab/addon/menumodel.dart';

class MenuItem {
  final String title;
  final String description;
  final String price;
  final String imagePath;

  MenuItem({
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  //MenuServices menuServices = MenuServices();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: FutureBuilder(
        future: fetchAllData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.foods!.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < snapshot.data!.foods!.length &&
                  index < snapshot.data!.images!.length) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MenuItemScreen(
                                title: snapshot.data!.foods![index].name
                                    .toString(),
                                description: snapshot
                                    .data!.foods![index].description
                                    .toString(),
                                price: snapshot.data!.foods![index].price
                                    .toString(),
                                imagePath: snapshot.data!.images![index].path
                                    .toString(),
                              )),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                                'http://ssr.coderouting.com${snapshot.data!.images![index].path.toString()}')),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.foods![index].name.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.foods![index].description
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                snapshot.data!.foods![index].price.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox(); // Placeholder widget or handle the error case
              }
            },
          );
        },
      ),
    );
  }
}

class MenuItemScreen extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imagePath;

  const MenuItemScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
