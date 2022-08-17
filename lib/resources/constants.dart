import 'package:flutter/material.dart';
import 'package:my_app/core/service/shared_prefs/shared_prefs_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/network/network_manager.dart';
import '../features/home/models/news_response.dart';

// Global parameters
String queryHolder = "";
NewsResponse? news;
NetworkManager manager = NetworkManager.instance;
Future<SharedPreferences> get globalSharedPrefs async =>
    await SharedPrefsManager.instance;
String appBarTitle = "Appcent NewsApp";

// Enums
enum PageState { loading, error, done }

enum SearchState { searching, notSearching }

enum SharedPrefsKeys { likedNews }

// Controllers

ScrollController listViewController = ScrollController();
TextEditingController searchController = TextEditingController();

// Constant variables
class Constants {
  static var color = _Colors();
  static var textStyle = _TextStyles();
  static var api = _API();
  static var images = _Images();
}

class _Colors {
  Color themeColor = Color.fromARGB(255, 26, 10, 67);
}

class _TextStyles {
  TextStyle blackBold = const TextStyle(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle blackRegular = const TextStyle(color: Colors.black, fontSize: 18);
  TextStyle whiteBold = const TextStyle(
      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);
  TextStyle whiteRegular = const TextStyle(color: Colors.white, fontSize: 18);
}

class _API {
  String apiKey = "e4a638184ec64001a1e8249209287b3c";
  String baseUrl = "https://newsapi.org/v2/";
}

class _Images {
  String noImage = "assets/no_image.png";
}
