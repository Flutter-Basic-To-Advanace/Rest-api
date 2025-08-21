import 'package:app_routing/api/api_service.dart';
import 'package:app_routing/models/product_model.dart';
import 'package:app_routing/screen/edit_product.dart';
import 'package:flutter/material.dart';

class SingleProduct extends StatelessWidget {
  final int productId;
  SingleProduct({super.key, required this.productId});

  final ApiService apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product details")),
      body: SingleChildScrollView(
        child: FutureBuilder<Product>(
          future: apiService.fetchSingleProduct(productId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("error :${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return Center(child: Text("Product not found"));
            } else {
              Product product = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      product.image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 16.0),
                    Text(product.title, style: TextStyle(fontSize: 24)),
                    SizedBox(height: 8.0),
                    Text(
                      "\$${product.price}",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(product.description),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProduct(product: product),
                              ),
                            );
                          },
                          child: const Text("Edit"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
