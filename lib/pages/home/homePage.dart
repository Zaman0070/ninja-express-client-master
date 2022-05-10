import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/category/categoriesPage.dart';
import 'package:ninja_express_client/pages/order/ordersPage.dart';
import 'package:ninja_express_client/pages/profile/profilePage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({required this.token});
  @override
  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Position initial
  List<Widget> _children = [];
  User currentuser = User(id: 1, name: "none", phone: "", photo: "", userid: 1, cartId: 0);

  @override
  void initState() {
    getuser();
    _children = [
      CategoriesPage(token: widget.token, user: currentuser),
      OrdersPage(token: widget.token, user: currentuser),
      ProfilePage(token: widget.token, user: currentuser)
    ];
    super.initState();
  }

  getuser() async {
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'jwt', value: widget.token);

    currentuser = (await Beckend().getuser(token: widget.token))!;
    setState(() {});
  }

  @override
  void setState(VoidCallback fn) {
    _children = [
      CategoriesPage(
        token: widget.token,
        user: currentuser,
      ),
      OrdersPage(token: widget.token, user: currentuser),
      ProfilePage(token: widget.token, user: currentuser)
    ];
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: customBottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          // Icon items
          BottomNavigationBarItem(icon: Icon(Icons.local_mall_rounded), label: 'Categorias'),
          BottomNavigationBarItem(icon: Icon(Icons.room_service), label: 'Pedidos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil', backgroundColor: white)
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
