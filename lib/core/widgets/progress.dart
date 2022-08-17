import 'package:flutter/material.dart';

import '../../Resources/constants.dart';

class Progress extends StatelessWidget {
  const Progress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: Constants.color.themeColor,
          )),
    );
  }
}
