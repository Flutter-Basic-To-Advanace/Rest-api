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

  // add the product to the API
  Future<Product> addProduct(Product product) async {
    const String url = "https://fakestoreapi.com/products";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );

      print("response status code :${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response:${response.body}");
        Product newProduct = Product.fromJson(json.decode(response.body));
        return newProduct;
      } else {
        print("Failed to add product. Status code : ${response.statusCode}");
        print("Response body:${response.body}");
        throw Exception("Failed to add product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to add product");
    }
  }

  //update a product in the API
  Future<Product> updatedProduct(int id, Product product) async {
    final String url = "https://fakestoreapi.com/products/$id";
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(product.toJson()),
      );
      if (response.statusCode == 200) {
        print(("response:${response.body}"));
        Product updatedProduct = Product.fromJson(json.decode(response.body));
        return updatedProduct;
      } else {
        print("Failed to Updated product. Status code: ${response.statusCode}");
        throw Exception("Failed to update product");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to update product");
    }
  }
}
