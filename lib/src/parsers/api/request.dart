class ApiRequest {
  final String url;
  final RequestType type;
  final Map<String, String>? headers;
  final Map<String, dynamic>? body;

  ApiRequest({
    required this.url,
    this.type: RequestType.post,
    this.headers,
    this.body,
  });

  factory ApiRequest.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ApiRequest(url: "");
    return ApiRequest(
      url: json['url'],
      type: _getType(
        json['type'],
      ),
      headers: json['headers'] as Map<String, String>?,
      body: json['body'] as Map<String, dynamic>?,
    );
  }

  ApiRequest copyWith({
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    RequestType? type,
  }) {
    return ApiRequest(
        url: this.url,
        headers: headers ?? this.headers,
        body: body ?? this.body,
        type: type ?? this.type);
  }

  static RequestType _getType(String? type) {
    switch (type) {
      case 'get':
        return RequestType.get;
      case 'put':
        return RequestType.put;
      default:
        return RequestType.post;
    }
  }
}

enum RequestType { get, post, put }
