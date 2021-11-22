
import 'package:ecommerce_app/provider/admin_mode.dart';
import 'package:ecommerce_app/provider/cart_item.dart';
import 'package:ecommerce_app/screens/cart_screen.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/order_details.dart';
import 'package:ecommerce_app/screens/product_info.dart';
import 'package:ecommerce_app/screens/view_product.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  bool isUserLogin=false;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode()..getProductData(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        )
      ],
      child: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }else{
            isUserLogin = snapshot.hasData ?? false;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.black87,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      elevation: 0,
                      selectedItemColor: Colors.black54,
                      unselectedItemColor: Colors.black,
                      showSelectedLabels: true,
                      showUnselectedLabels: true
                  )
              ),
              routes: {
                ProductInfo.id: (context) => ProductInfo(),
                CartScreen.id: (context) => CartScreen(),
                ViewProduct.id: (context) => ViewProduct(),
                OrderDetails.id: (context) => OrderDetails(),
              },
              home: isUserLogin ? LoginScreen(): HomeScreen(),
            );
          }
        }
      ),
    );
  }
}

