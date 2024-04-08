import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            product.title ?? ''), // Sử dụng toán tử ?? để xử lý giá trị null
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500,
              width: double.infinity,
              child: Image.network(product.imageUrl ?? '',
                  fit:
                      BoxFit.cover), // Sử dụng toán tử ?? để xử lý giá trị null
            ),
            const SizedBox(height: 10),
            Text(
              '\$${product.price ?? ''}', // Sử dụng toán tử ?? để xử lý giá trị null
              style: const TextStyle(
                  color: Color.fromARGB(255, 113, 181, 233), fontSize: 25),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                product.description ??
                    '', // Sử dụng toán tử ?? để xử lý giá trị null
                textAlign: TextAlign.center,
                softWrap: true,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
