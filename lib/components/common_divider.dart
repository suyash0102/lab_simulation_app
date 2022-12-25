import 'package:flutter/material.dart';

class CommonDivider extends StatelessWidget {
  const CommonDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 12),
      child: Divider(
        color: Color(0xFF797979),
        thickness: 1.5,
      ),
    );
  }
}