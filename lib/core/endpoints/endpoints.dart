abstract class EndPoints {
  String get getNews;
}

class IEndPoints extends EndPoints {
  @override
  String get getNews => "everything";
}
