import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/resources/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsSource extends StatefulWidget {
  final String sourceUrl;
  const NewsSource({
    Key? key,
    required this.sourceUrl,
  }) : super(key: key);

  @override
  State<NewsSource> createState() => _NewsSourceState();
}

class _NewsSourceState extends State<NewsSource> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.color.themeColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("News Source"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: widget.sourceUrl,
      ),
    );
  }
}
