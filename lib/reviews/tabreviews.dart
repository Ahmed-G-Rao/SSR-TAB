import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ssrtab/reviews/reviewsmodel.dart';
import 'package:http/http.dart' as http;

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Future<ReviewsModel> fetchAllData() async {
    final response =
        await http.get(Uri.parse("http://ssr.coderouting.com/GetAllReviews"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      print("data $data");
      return ReviewsModel.fromJson(data);
    } else {
      return ReviewsModel.fromJson(data);
    }
  }

  double _foodRating = 0;
  String _additionalComments = '';

  Future<void> _submitReview() async {
    final response = await http.post(
      Uri.parse('http://ssr.coderouting.com/AddReview'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        "user_id": "ABCD",
        "review": _additionalComments,
        "stars": _foodRating,
      }),
    );

    print(response.body);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Review Added"),
          actions: [
            Center(
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      );
      setState(() {
        _additionalComments = "";
        _foodRating = 0.0;
      });
    }
  }

  Widget buildStarRating(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(Icons.star, color: Colors.yellow);
        } else {
          return Icon(Icons.star, color: Colors.grey);
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Reviews'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Give Us Rating',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _foodRating = i.toDouble();
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: 40,
                        color: i <= _foodRating ? Colors.yellow : Colors.grey,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Write us Comments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _additionalComments = value;
                  });
                },
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Write your comments...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReview,
                child: const Text('Submit Review'),
              ),
              const SizedBox(height: 20),
              FutureBuilder<ReviewsModel>(
                future: fetchAllData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    print("Error ");
                    return const SizedBox();
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      final reviewsData = snapshot.data!.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Text(
                                            //   "${reviewsData.user_name}",
                                            //   style: const TextStyle(
                                            //     fontSize: 36.0,
                                            //     fontWeight: FontWeight.bold,
                                            //   ),
                                            // ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              DateFormat('MMMM dd, yyyy')
                                                  .format(DateTime.parse(
                                                      reviewsData.createdAt
                                                          .toString())),
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    buildStarRating(
                                        (reviewsData.stars ?? 0).toDouble()),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Text(
                                  reviewsData.review.toString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ReviewScreen(),
  ));
}
