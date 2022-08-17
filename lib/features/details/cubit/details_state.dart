// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:my_app/resources/constants.dart';

import '../../home/models/article_response.dart';

class DetailsState {
  final int? likedNewsCount;
  final PageState? pageState;
  final bool? alreadyLiked;

  DetailsState({
    this.likedNewsCount,
    this.pageState,
    this.alreadyLiked,
  });

  DetailsState copyWith({
    int? likedNewsCount,
    List<Articles>? likedArticles,
    PageState? pageState,
    bool? alreadyLiked,
  }) {
    return DetailsState(
      likedNewsCount: likedNewsCount ?? this.likedNewsCount,
      pageState: pageState ?? this.pageState,
      alreadyLiked: alreadyLiked ?? this.alreadyLiked,
    );
  }
}
