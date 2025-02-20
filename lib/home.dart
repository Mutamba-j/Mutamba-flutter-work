import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'model/product.dart';
import 'model/products_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  // Method to build grid cards from the products repository
  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = ProductsRepository.loadProducts(Category.all);

    if (products.isEmpty) {
      return const <Card>[]; // Return empty list if no products
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).toString(),
    );

    return products.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth, // Fit the image within the box
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Updated text style to use bodyLarge instead of bodyText1
                    Text(
                      product.name,
                      style: theme.textTheme.bodyLarge, // Updated to bodyLarge
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.bodySmall, // This should be valid in recent Flutter versions
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SHRINE'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            print('Menu button clicked');
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print('Search button clicked');
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              print('Filter button clicked');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2, // Number of columns in the grid
        padding: const EdgeInsets.all(16.0), // Padding around the grid
        childAspectRatio: 8.0 / 9.0, // Aspect ratio of each card
        children: _buildGridCards(context), // Build cards based on products
      ),
      resizeToAvoidBottomInset: false, // Prevent resizing when keyboard appears
    );
  }
}