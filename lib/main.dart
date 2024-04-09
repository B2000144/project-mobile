import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myshop/ui/product/products_overview_screen.dart';
import 'ui/product/product_detail_screen.dart';
import 'ui/product/products_manager.dart';
import 'ui/product/user_products_screen.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/order/orders_screen.dart';
import 'ui/screens.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.blue,
      secondary: Colors.deepOrange,
      background: Colors.white,
      surfaceTint: Colors.grey[200],
    );

    final themeData = ThemeData(
      // Thêm định nghĩa dialogTheme vào ThemeData
      dialogTheme: DialogTheme(
        titleTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        contentTextStyle: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 20,
        ),
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        )
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: colorScheme,
          appBarTheme: AppBarTheme(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              elevation: 4,
              shadowColor: colorScheme.shadow),
        ),
        home: const MyHomePage(),
        routes: {
          CartScreen.routeName: (ctx) => const SafeArea(
                child: CartScreen(),
              ),
          OrdersScreen.routeName: (ctx) => const SafeArea(
                child: OrdersScreen(),
              ),
          UserProductsScreen.routeName: (ctx) => const SafeArea(
                child: UserProductsScreen(),
              ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final productId = settings.arguments as String;
            final product = ProductsManager().findById(productId);
            if (product != null) {
              // Kiểm tra xem product có null không
              return MaterialPageRoute(
                settings: settings,
                builder: (ctx) {
                  return SafeArea(
                    child: ProductDetailScreen(
                      ctx.read<ProductsManager>().findById(productId)!,
                    ),
                  );
                },
              );
            } else {
              // Xử lý trường hợp product không tồn tại
              // Ví dụ: Hiển thị một thông báo lỗi hoặc chuyển hướng đến màn hình khác
            }
          }
          return null;
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ProductsOverviewScreen(),
    CartScreen(),
    OrdersScreen(),
    UserProductsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //   title: const Text('My Shop'),
      // ), // Thêm AppDrawer vào đây
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.blue),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment, color: Colors.blue),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create_sharp, color: Colors.blue),
            label: 'Edit',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onBackground,
        onTap: _onItemTapped,
      ),
    );
  }
}
