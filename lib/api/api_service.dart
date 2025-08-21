import 'dart:convert';

import 'package:app_routing/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  //Fetch all products from the API
  Future<List<Product>> fetchAllProducts() async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<Product> products = responseData.map((json) {
          return Product.fromJson(json);
        }).toList();
        return products;
      } else {
        print(
          "Failed to fetch the products the status code: ${response.statusCode} ",
        );
        throw Exception("Failed to fetch products");
      }
    } catch (error) {
      print("Error : $error");
      throw Exception("Failed to fetch products");
    }
  }

  //fetch a single product from the API
  Future<Product> fetchSingleProduct(int id) async {
    final String url = "https://fakestoreapi.com/products/$id";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Product product = Product.fromJson(json.decode(response.body));
        return product;
      } else {
        print("Failed to fetch produt.Status code : ${response.body}");
        throw Exception("Failed to fetch product");
      }
    } catch (error) {
      print("Error : $error");
      throw Exception("Failed to fetch the product");
    }
  }
}
