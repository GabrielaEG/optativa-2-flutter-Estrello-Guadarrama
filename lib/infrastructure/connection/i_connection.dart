abstract class IConnection {
  Future<T> get<T>(String url, {Map<String, String>? headers});
  Future<T> post<T, D>(String url, D data, {Map<String, String>? headers});
}