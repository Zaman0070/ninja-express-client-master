import 'package:flutter/material.dart';
import 'package:ninja_express_client/pages/auth/signInPage.dart';
import 'package:ninja_express_client/pages/home/homePage.dart';
import 'package:ninja_express_client/provider/auth_provider.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

String? _token = "";
final storage = new FlutterSecureStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _token = await storage.read(key: 'jwt');
  if (_token == null) {
    _token = "";
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AuthProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: windsor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: _token == "" ? SignInPage() : HomePage(token: _token!)));
  }
}
