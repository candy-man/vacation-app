import 'package:flutter/cupertino.dart';

class DaysView extends StatelessWidget {
  final String label;
  final String value;
  final Color background;
  final Color textColor;

  const DaysView(
      {super.key,
      required this.label,
      required this.value,
      required this.background,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                      fontSize: 14.00,
                      color: textColor,
                    ))
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value,
                      style: TextStyle(fontSize: 14.00, color: textColor)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
