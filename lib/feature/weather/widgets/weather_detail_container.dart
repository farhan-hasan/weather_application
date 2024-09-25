import 'package:flutter/material.dart';

import '../../../config/app_themes.dart';

class WeatherDetailContainer extends StatelessWidget {
  WeatherDetailContainer({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.icon,
    super.key,
  });

  IconData icon;
  String title;
  String subtitle;
  String trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width / 2.3,
      height: MediaQuery.of(context).size.width / 6,
      decoration: BoxDecoration(
          color: AppThemes.lightColorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Wrap(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                subtitle,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            ],
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   heightFactor: .6,
          //   child: Text(
          //     trailing,
          //     style: const TextStyle(fontWeight: FontWeight.w500),
          //   ),
          // )
        ],
      ),
    );
  }
}
