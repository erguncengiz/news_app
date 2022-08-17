import 'package:flutter/material.dart';

import '../../../core/widgets/news_card.dart';
import '../../home/models/article_response.dart';

class Favorites extends StatefulWidget {
  final List<Articles>? likedArticles;
  const Favorites({Key? key, this.likedArticles}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          thickness: 2,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            NewsCard(news: widget.likedArticles![index], index: index),
        itemCount: widget.likedArticles!.length,
      ),
    );
  }
}
