import 'package:flutter/material.dart';

import '../../resources/constants.dart';

class InfoWidget extends StatelessWidget {
  final String author;
  final Icon icon;
  const InfoWidget({
    Key? key,
    required this.author,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
        Text(
          author,
          style: Constants.textStyle.blackRegular,
        ),
      ],
    );
  }
}
