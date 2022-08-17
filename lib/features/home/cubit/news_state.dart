// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_app/features/home/models/news_response.dart';

import '../../../resources/constants.dart';
import '../models/article_response.dart';

class NewsState {
  final NewsResponse? response;
  final bool? scrolled;
  final String? errorMessage;
  final PageState? pageState;
  final int? selectedIndex;
  final List<Articles>? likedArticles;

  NewsState({
    this.response,
    this.scrolled,
    this.errorMessage,
    this.pageState,
    this.selectedIndex = 0,
    this.likedArticles,
  });

  NewsState copyWith({
    NewsResponse? response,
    bool? scrolled,
    String? errorMessage,
    PageState? pageState,
    int? selectedIndex,
    List<Articles>? likedArticles,
  }) {
    return NewsState(
      response: response ?? this.response,
      scrolled: scrolled ?? this.scrolled,
      errorMessage: errorMessage ?? this.errorMessage,
      pageState: pageState ?? this.pageState,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      likedArticles: likedArticles ?? this.likedArticles,
    );
  }
}
