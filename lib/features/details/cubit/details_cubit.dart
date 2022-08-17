import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:my_app/features/home/models/article_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/constants.dart';
import 'details_state.dart';
import '../../../core/extensions/extensions.dart';

class DetailsCubit extends Cubit<DetailsState> {
  late SharedPreferences sharedPrefs;
  late List<Articles> articles = [];
  final Articles article;
  DetailsCubit(this.article) : super(DetailsState());

  fetchSharedPrefsAndLikedArticles() async {
    sharedPrefs = await SharedPreferences.getInstance();
    getLikedNews(article);
  }

  getLikedNews(Articles passedArticle) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      List<String> tmpArticlesList =
          sharedPrefs.getStringList(SharedPrefsKeys.likedNews.rawValue) ?? [];
      print("Get completed list length : ${tmpArticlesList.length}!");
      print("List : $tmpArticlesList!");
      for (var element in tmpArticlesList) {
        Articles tmpArticle = Articles.fromJson(jsonDecode(element));
        if (tmpArticle.url == passedArticle.url) {
          emit(state.copyWith(alreadyLiked: true));
        }
        articles.add(tmpArticle);
      }
      emit(state.copyWith(
        pageState: PageState.done,
      ));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        pageState: PageState.error,
      ));
    }
  }

  saveLikedArticle() async {
    List<String> tmpStringArticles = [];
    for (var element in articles) {
      tmpStringArticles.add(jsonEncode(element));
    }
    tmpStringArticles.add(jsonEncode(article));
    sharedPrefs.setStringList(
        SharedPrefsKeys.likedNews.rawValue, tmpStringArticles);
    print("Write completed!");
    emit(state.copyWith(alreadyLiked: true));
  }

  Future<void> share(String newsLink) async {
    await FlutterShare.share(
      title: 'Hey look at this!',
      text: newsLink,
      linkUrl: newsLink,
    );
  }
}
