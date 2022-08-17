import 'package:flutter/material.dart';
import 'package:my_app/features/home/models/article_response.dart';
import 'package:my_app/features/home/models/news_response.dart';
import '../../Resources/constants.dart';
import '../../features/details/view/details_screen.dart';

class NewsCard extends StatelessWidget {
  final Articles news;
  final int index;

  const NewsCard({
    Key? key,
    required this.news,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsOfNew(
                    article: news,
                  )),
        );
      },
      title: Text(
        news.title!,
        style: Constants.textStyle.blackBold,
        maxLines: 1,
      ),
      subtitle: Text(
        news.content!,
        style: Constants.textStyle.blackRegular,
        maxLines: 2,
      ),
      trailing: SizedBox(
        width: (MediaQuery.of(context).size.width / 3),
        child: news.urlToImage != null
            ? Image.network(
                news.urlToImage!,
                errorBuilder: (context, exception, stackTrace) {
                  return Image.asset(Constants.images.noImage);
                },
              )
            : Image.asset(Constants.images.noImage),
      ),
    );
  }
}
