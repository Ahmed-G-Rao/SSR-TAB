// import 'package:flutter/material.dart';
// import 'package:ssrtab/all_table_ordering.dart';
// import 'package:ssrtab/tabpayment.dart';

// import 'reviews/tabreviews.dart';

// class TabletScreen extends StatelessWidget {
//   const TabletScreen({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'SMART SERVE RESTAURANT',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 50, width: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle Add on Box button press
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => MenuScreen()),
//                           );
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.add),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Add on Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 50, height: 50),
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle Call Waiter Box button press
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.call),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Call Waiter Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50, width: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle Pay Bill Box button press
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const PaymentScreen()),
//                           );
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.payment),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Pay Bill Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 50, height: 50),
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const ReviewScreen()),
//                           );
//                           // Handle Review Box button press
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.star),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Reviews Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 50, width: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle FAQs Box button press
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>  FAQScreen()),
//                           );
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.more),
//                               SizedBox(height: 8),
//                               Text(
//                                 'FAQs Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 50, height: 50),
//                   Expanded(
//                     child: SizedBox(
//                       height: 100,
//                       width: 100,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle Sign out Box button press
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8.0),
//                           child: Column(
//                             children: [
//                               Icon(Icons.exit_to_app),
//                               SizedBox(height: 8),
//                               Text(
//                                 'Sign out Box',
//                                 textAlign: TextAlign.center,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: const TabletScreen(),
//       ),
//     ),
//   ));
// }
