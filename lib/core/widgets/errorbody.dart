import 'package:flutter/material.dart';

import '../../Resources/constants.dart';

class ErrorBody extends StatelessWidget {
  final String errorMessage;

  const ErrorBody({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: Constants.textStyle.blackBold.copyWith(fontSize: 24),
      ),
    );
  }
}
