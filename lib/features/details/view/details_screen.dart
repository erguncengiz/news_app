import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_app/core/widgets/errorbody.dart';
import 'package:my_app/core/widgets/progress.dart';
import 'package:my_app/features/details/details.dart';
import 'package:my_app/features/home/models/article_response.dart';
import 'package:my_app/features/source/news_source.dart';
import 'package:my_app/resources/constants.dart';
import 'dart:io';

import '../../../core/widgets/info_widget.dart';

class DetailsOfNew extends StatefulWidget {
  final Articles article;

  const DetailsOfNew({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<DetailsOfNew> createState() => _DetailsOfNewState();
}

class _DetailsOfNewState extends State<DetailsOfNew> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsCubit(widget.article)..fetchSharedPrefsAndLikedArticles(),
      child: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          return Scaffold(
              appBar: buildAppBar(context, state),
              body: buildBody(state),
              floatingActionButton: buildFab(context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat);
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, DetailsState state) {
    return AppBar(
      backgroundColor: Constants.color.themeColor,
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          )),
      actions: [
        IconButton(
          onPressed: () {
            context
                .read<DetailsCubit>()
                .share(widget.article.url ?? "https://www.google.com");
          },
          icon: const Icon(
            Icons.ios_share,
            color: Colors.white,
          ),
        ),
        IconButton(
            onPressed: (state.alreadyLiked ?? false)
                ? null
                : () {
                    context.read<DetailsCubit>().saveLikedArticle();
                  },
            icon: Icon(
              Icons.favorite,
              color: (state.alreadyLiked ?? false) ? Colors.red : Colors.white,
            ))
      ],
    );
  }

  Widget buildBody(DetailsState state) {
    if (state.pageState == PageState.loading) {
      return const Progress();
    } else if (state.pageState == PageState.done) {
      return SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: widget.article.urlToImage != null
                  ? Image.network(
                      widget.article.urlToImage!,
                      errorBuilder: (context, exception, stackTrace) {
                        return Image.asset(Constants.images.noImage);
                      },
                    )
                  : Image.asset(Constants.images.noImage),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.article.title ?? "No Title",
                style: Constants.textStyle.blackBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoWidget(
                    author: widget.article.author ?? "No Author",
                    icon: const Icon(Icons.newspaper),
                  ),
                  InfoWidget(
                    author: DateFormat.yMd()
                        .format(DateTime.parse(widget.article.publishedAt!))
                        .toString(),
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.article.content ?? "No Content",
                style: Constants.textStyle.blackRegular,
              ),
            ),
          ],
        ),
      );
    } else if (state.pageState == PageState.error) {
      return const ErrorBody(errorMessage: "-Upps!");
    } else {
      return const SizedBox();
    }
  }

  Widget buildFab(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: FloatingActionButton(
        backgroundColor: Constants.color.themeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsSource(
                      sourceUrl: widget.article.url!,
                    )),
          );
        },
        child: Text(
          "News Source",
          style: Constants.textStyle.whiteRegular,
        ),
      ),
    );
  }
}
