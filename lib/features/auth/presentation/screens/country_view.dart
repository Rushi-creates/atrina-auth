// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import '../controllers/country_controller.dart';

// class CountryView extends StatelessWidget {
//   final controller = Get.find<CountryController>();

//   @override
//   Widget build(BuildContext context) {
//     final client = GraphQLProvider.of(context).value;

//     // Fetch countries when view is built
//     controller.fetchCountries(client);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Countries with GraphQL + GetX"),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.error.isNotEmpty) {
//           return Center(child: Text("Error: ${controller.error}"));
//         }

//         return ListView.builder(
//           itemCount: controller.countries.length,
//           itemBuilder: (context, index) {
//             final country = controller.countries[index];
//             return ListTile(
//               leading: Text(country['emoji']),
//               title: Text(country['name']),
//               subtitle: Text("Code: ${country['code']}"),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
