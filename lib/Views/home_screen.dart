import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/logos/icon-app-chat.jpg'), // Thêm ảnh logo vào thư mục assets
            ),
            SizedBox(height: 10),

            Text(
              "Chatting With Friends",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
                fontFamily: 'Times New Roman',
              ),
            ),
            SizedBox(height: 20),


            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Nhập tên của bạn.....",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 15),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade900,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  GoRouter.of(context).go("/chat",
                      extra: nameController.text,
                  );
                }
              },
              child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            SizedBox(height: 20),


            Padding(
              padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
              child: Divider(color: Colors.blue, thickness: 1),
            ),
            SizedBox(height: 10),


            Text(
              "With",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialButton(FontAwesomeIcons.facebook, Colors.blue),
                SizedBox(width: 15),
                _buildSocialButton(FontAwesomeIcons.google, Colors.red),
                SizedBox(width: 15),
                _buildSocialButton(FontAwesomeIcons.instagram, Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSocialButton(IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.2),
      ),
      child: IconButton(
        icon: FaIcon(icon, color: color, size: 30),
        onPressed: () {
          // cho~ nay` thao tac' cho cac' icon, chua can` bo~ gi` zo cho~ nay`
        },
      ),
    );
  }
}
