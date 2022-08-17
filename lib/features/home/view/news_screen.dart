import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/resources/constants.dart';

import '../../../core/widgets/news_card.dart';
import '../../../core/widgets/progress.dart';
import '../../favorites/view/favorites_screen.dart';
import '../cubit/news_cubit.dart';
import '../cubit/news_state.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..setScrollListener()
        ..fetchSharedPrefsAndLikedArticles(),
      child: buildScaffold(),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            return Text(
              state.selectedIndex == 0 ? "Appcent NewsApp" : "Favorites",
              style: Constants.textStyle.whiteBold,
            );
          },
        ),
        backgroundColor: Constants.color.themeColor,
      ),
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (BuildContext context, NewsState state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: buildTextFormField(context, state),
              ),
              state.selectedIndex == 0
                  ? buildBody(state)
                  : Favorites(
                      likedArticles: state.likedArticles,
                    )
            ],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: state.selectedIndex ?? 0,
            selectedItemColor: Colors.amber[800],
            onTap: ((value) {
              context.read<NewsCubit>().onItemTapped(value);
            }),
          );
        },
      ),
    );
  }

  Widget buildTextFormField(BuildContext context, NewsState state) {
    return Visibility(
      visible: state.selectedIndex == 0,
      child: TextFormField(
        cursorColor: Constants.color.themeColor,
        autocorrect: false,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Constants.color.themeColor,
          ),
          suffixIcon: IconButton(
              onPressed: () {
                searchController.clear();
                context.read<NewsCubit>().searchNews("");
              },
              icon: Icon(
                Icons.close,
                color: Constants.color.themeColor,
              )),
          hintText: "Type to search",
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.color.themeColor,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Constants.color.themeColor,
              width: 2.0,
            ),
          ),
        ),
        controller: searchController,
        onChanged: ((value) {
          context.read<NewsCubit>().searchNews(value);
        }),
      ),
    );
  }

  Widget buildBody(NewsState state) {
    switch (state.pageState) {
      case PageState.error:
        return Expanded(
          child: Center(
            child: Text(
              "Type something in the search bar to find anything!",
              style: Constants.textStyle.blackBold.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      case PageState.loading:
        return const Progress();
      case PageState.done:
        return Expanded(
          child: Stack(
            children: [
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  thickness: 2,
                ),
                physics: state.scrolled!
                    ? const NeverScrollableScrollPhysics()
                    : null,
                shrinkWrap: true,
                controller: listViewController,
                itemBuilder: (context, index) => NewsCard(
                    news: state.response!.articles![index], index: index),
                itemCount: state.response!.articles!.length,
              ),
              Visibility(visible: state.scrolled!, child: const Progress())
            ],
          ),
        );
      default:
        return Expanded(
          child: Center(
            child: Text(
              "Type something in the search bar to find anything!",
              style: Constants.textStyle.blackBold.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }
}
