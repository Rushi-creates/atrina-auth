// import 'package:get/get.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// class CountryController extends GetxController {
//   var isLoading = true.obs;
//   var countries = [].obs;
//   var error = ''.obs;

//   final String query = """
//     query {
//       countries {
//         code
//         name
//         emoji
//       }
//     }
//   """;

//   void fetchCountries(GraphQLClient client) async {
//     isLoading(true);
//     error('');

//     final result = await client.query(QueryOptions(document: gql(query)));

//     if (result.hasException) {
//       error(result.exception.toString());
//     } else {
//       countries(result.data?['countries'] ?? []);
//     }

//     isLoading(false);
//   }
// }
