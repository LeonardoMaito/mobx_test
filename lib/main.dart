import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/views/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    home:LoginPage(),
    debugShowCheckedModeBanner: false,));
}
