import 'package:flutter/material.dart';

class optionWidget extends StatelessWidget {
  optionWidget({super.key, required this.title, required this.icon});

  String title;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      child: Center(
        child: Column(
          children: [
            InkWell(
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black.withOpacity(0.5),
                child: Icon(icon),
              ),
            ),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
