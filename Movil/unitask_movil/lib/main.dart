import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_item_screen.dart';
import 'screens/edit_item_screen.dart';
import 'models/item_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD con API',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/add': (context) => const AddItemScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/edit') {
          final item = settings.arguments as Item;
          return MaterialPageRoute(
            builder: (context) => EditItemScreen(item: item),
          );
        }
        return null;
      },
    );
  }
}
