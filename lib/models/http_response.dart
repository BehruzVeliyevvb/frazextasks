class HTTPResponse<T> {
  late bool isSuccessful;
  late T? data;
  late String? message;
  late int? statusCode;
  HTTPResponse(this.isSuccessful, this.data, {this.message, this.statusCode});
}
