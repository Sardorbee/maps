import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const MyButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
          height: 40,
          width: 80,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  color: color,
                ),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(color: color, fontSize: 16),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
