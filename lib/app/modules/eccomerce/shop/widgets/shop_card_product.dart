// import 'package:flutter/material.dart';

// class ShopCardProduct extends StatelessWidget {
//   final List<Map<String, dynamic>> product;
//   const ShopCardProduct({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       elevation: 6,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
//               child: Image.asset(product["image"], fit: BoxFit.cover, width: double.infinity),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(product["title"], maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//                 const SizedBox(height: 4),
//                 Text("Desconto: ${product["discount"]}%", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 4),
//                 Text("R\$ ${product["price"].toStringAsFixed(2)}", style: const TextStyle(fontSize: 14)),
//                 const SizedBox(height: 4),
//                 Text("Termina em: ${product["timeLeft"]}", style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
