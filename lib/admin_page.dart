import 'package:flutter/material.dart';
import 'package:online_recruitment/Screens/customer.dart';
import 'package:online_recruitment/add_admin.dart';
import 'package:online_recruitment/add_job.dart';
import 'package:online_recruitment/constants.dart';
import 'package:online_recruitment/employee_page.dart';
import 'package:online_recruitment/registrar.dart';

import 'controller/auth_controller.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);
  AuthController auth = AuthController();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('Admin Page'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                auth.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Customers',
                  nav: Customers(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'add user',
                  nav: AddAdmin(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Jobs',
                  nav: RegistrarPage(),
                ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: kPrimaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
