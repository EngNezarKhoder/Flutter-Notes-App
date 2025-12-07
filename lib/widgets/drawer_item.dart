import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.onTap,
      required this.icon,
      required this.color,
      required this.title});
  final void Function()? onTap;
  final IconData icon;
  final Color color;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
        size: 28,
      ),
      title: Text(
        title,
        style:
            TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
