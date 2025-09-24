import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;

  // ignore: use_super_parameters
  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF7A0C0C),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              Positioned(
                right: 5,
                top: 0,
                child: CircleAvatar(radius: 4, backgroundColor: Colors.white12),
              ),
            ],
          ),
        )
      ],
    );
  }
}
