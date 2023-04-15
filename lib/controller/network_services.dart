import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shopping_api/model/model.dart';

class NetworkServices {
  static const String url = 'https://fakestoreapi.com/products';

  static Future<List<ProductModel>> fetchProductDatas() async {
    final Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    final json = productModelFromJson(response.body);
    return json;
  }
}
