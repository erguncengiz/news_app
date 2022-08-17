import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../features/home/models/news_response.dart';
import '../../../../resources/constants.dart';
import '../../domain/repository/request_helpers.dart';
import '../../../extensions/extensions.dart';

class HelperFunctionsImpl implements HelperFunctions {
  @override
  Future<NewsResponse> searchNews(
      String apiKey, int pageNumber, String endPoint, String query) async {
    NewsResponse response;
    Response? tmpResponse;
    try {
      tmpResponse =
          await manager.dio.get(endPoint.addEndPoint(), queryParameters: {
        'apiKey': apiKey,
        'page': pageNumber,
        'q': query,
      });
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
    response = NewsResponse.fromJson(tmpResponse!.data);
    return response;
  }
}
