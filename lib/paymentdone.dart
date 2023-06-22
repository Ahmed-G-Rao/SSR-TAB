import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ssrtab/main.dart';
import 'package:ssrtab/reviews/tabreviews.dart';

class PaymentDoneScreen extends StatelessWidget {
  const PaymentDoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'animations/116087-payment-success.json',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Thank you for coming! Should you find yourself absolutely loving it, we would love it if you left us a review!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your review button functionality here
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ReviewScreen()),
                      );
                    },
                    child: const Text(
                      'Review Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your "Back to Home" button functionality here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TabletScreen()),
                      );
                    },
                    child: const Text(
                      'Back To Home',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PaymentDoneScreen(),
  ));
}
