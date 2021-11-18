
class Result<T>{
  T data;
  bool error;
  bool networkAvailable;
  String errorMessage;
  String message;
  int errorCode;

  Result({this.data, this.error, this.errorMessage, this.networkAvailable, this.message, this.errorCode});
}