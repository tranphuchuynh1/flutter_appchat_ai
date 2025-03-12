import 'package:flutter/material.dart';
import 'package:flutter_appchat_ai/Views/colors.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdWhite,
      appBar: AppBar(title: Text("Nhập Username")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nhập tên của bạn",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  GoRouter.of(context).go("/chat", extra: nameController.text);
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
