import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/endpoints/endpoints.dart';
import 'package:my_app/core/extensions/extensions.dart';
import 'package:my_app/resources/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/service/data/repository/request_helpers_impl.dart';
import '../../../core/service/domain/repository/request_helpers.dart';
import '../models/article_response.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  late SharedPreferences sharedPrefs;
  late List<Articles> articles = [];

  NewsCubit() : super(NewsState());

  HelperFunctions helpers = HelperFunctionsImpl();
  EndPoints endPoints = IEndPoints();
  bool scrolled = false;
  int pageNumber = 1;

  fetchSharedPrefsAndLikedArticles() async {
    sharedPrefs = await SharedPreferences.getInstance();
    getLikedNews();
  }

  getLikedNews() async {
    try {
      articles = [];
      List<String> tmpArticlesList =
          sharedPrefs.getStringList(SharedPrefsKeys.likedNews.rawValue) ?? [];
      print("Get completed list length : ${tmpArticlesList.length}!");
      for (var element in tmpArticlesList) {
        Articles tmpArticle = Articles.fromJson(jsonDecode(element));
        articles.add(tmpArticle);
      }
      emit(state.copyWith(likedArticles: articles));
    } catch (e) {
      print(e);
      emit(state.copyWith(
        likedArticles: [],
      ));
    }
  }

  Future<void> searchNews(String query) async {
    try {
      emit(state.copyWith(pageState: PageState.loading));
      final response = query == ""
          ? null
          : await helpers.searchNews(
              Constants.api.apiKey, pageNumber, endPoints.getNews, query);
      news = response;
      queryHolder = query;
      emit(
        state.copyWith(
          response: news!,
          scrolled: scrolled,
          pageState: PageState.done,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          pageState: PageState.error,
        ),
      );
    }
  }

  Future<void> getNewsWithScroll() async {
    try {
      var response = await helpers.searchNews(
        Constants.api.apiKey,
        pageNumber,
        endPoints.getNews,
        queryHolder,
      );
      news!.articles!.addAll(response.articles!);
      scrolled = false;
      emit(
        state.copyWith(
          pageState: PageState.done,
          response: news!,
          scrolled: scrolled,
        ),
      );
    } catch (e) {
      print(e);
      emit(
        state.copyWith(
          pageState: PageState.error,
        ),
      );
    }
  }

  setScrollListener() {
    listViewController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(scrollListener);
  }

  scrollListener() async {
    if (listViewController.offset >=
            listViewController.position.maxScrollExtent &&
        !listViewController.position.outOfRange) {
      scrolled = true;
      pageNumber += 1;
      try {
        emit(
          state.copyWith(
            scrolled: true,
            pageState: PageState.done,
          ),
        );
        await getNewsWithScroll();
      } catch (e) {
        print(e);
      }
    }
  }

  onItemTapped(int index) {
    fetchSharedPrefsAndLikedArticles();
    emit(state.copyWith(selectedIndex: index));
  }
}
