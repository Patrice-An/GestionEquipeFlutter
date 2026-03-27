class HTTPContainer {
  final int _statusCode;
  final dynamic _data;

  HTTPContainer(this._statusCode, [this._data]);

  static HTTPContainer getInstance(int code, [dynamic data]) {
    return HTTPContainer(code, data);
  }

  int getCode(){
    return this._statusCode;
  }

  dynamic getData(){
    return this._data;
  }
}