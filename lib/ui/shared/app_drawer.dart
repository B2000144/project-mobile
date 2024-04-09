import 'package:flutter/material.dart';
import 'package:myshop/ui/product/products_overview_screen.dart';
import 'package:myshop/ui/cart/cart_screen.dart';
import 'package:myshop/ui/order/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Clothes Shop',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => const ProductsOverviewScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
