import '../../../../features/home/home.dart';

abstract class HelperFunctions {
  Future<NewsResponse> searchNews(
      String apiKey, int pageNumber, String endPoint, String query);
}
