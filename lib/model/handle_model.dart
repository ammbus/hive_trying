// handle_model.dart
class ResultModel {}

class ExceptionModel extends ResultModel {
  String message;
  ExceptionModel({
    required this.message,
  });
}

class ErrorModel extends ResultModel {
  String message;
  ErrorModel({
    required this.message,
  });
}

class ListOf<T> extends ResultModel {
  List<T> modelList;
  ListOf({
    required this.modelList,
  });
}
