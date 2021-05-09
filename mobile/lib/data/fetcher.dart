import 'dart:convert';
import 'package:coupons/data/multipartFile.dart';
import 'package:http/http.dart' as http;

abstract class Fetcher {
  Future<String> Function() _getToken;
  void setAuthTokenGetter(Future<String> Function() getToken) {
    _getToken = getToken;
  }

  Future<String> _authorizationHeaderValue() async {
    if (_getToken == null) return "";
    final String ac = await _getToken();
    return "Bearer $ac";
  }

  Future<T> getParsed<T>(String url, T Function(dynamic) parser) async {
    return parser.call(await _get(url));
  }

  Future<List<dynamic>> getList(String url) async {
    return await _get(url) as List;
  }

  Future<List<T>> getParsedList<T>(
    String url,
    T Function(dynamic) parser,
  ) async {
    List<dynamic> list = await getList(url);
    return list.map(parser).where((x) => x != null).toList();
  }

  Future<dynamic> post(String path, {dynamic body}) async {
    return _handelResponse(await http.post(
      Uri.parse(path),
      headers: await _jsonHeader(),
      body: body == null ? null : jsonEncode(body),
    ));
  }

  Future<void> postMultipart(
    String url, {
    Map<String, dynamic> fields,
    Map<String, MultipartFile> files,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.headers['Authorization'] = await _authorizationHeaderValue();

    if (fields != null) {
      for (var key in fields.keys) {
        request.fields[key] = fields[key].toString();
      }
    }
    if (files != null) {
      for (var key in files.keys) {
        request.files.add(
          http.MultipartFile.fromBytes(
            key,
            files[key].data,
            filename: files[key].filename,
          ),
        );
      }
    }

    _handelStreamedResponse(await request.send());
  }

  Future<dynamic> _get(String path) async {
    final rawResponse = await http.get(
      Uri.parse(path),
      headers: await _jsonHeader(),
    );
    return _handelResponse(rawResponse);
  }

  Future<Map<String, String>> _jsonHeader() async {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': await _authorizationHeaderValue()
    };
  }

  dynamic _handelResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        ResponseContentType type = parseContentType(response);
        if (type == ResponseContentType.json) {
          return jsonDecode(response.body);
        }
        return response.body;
      } on FormatException catch (ex) {
        print(ex);
        return null;
      }
    }
    // Fluttertoast.showToast(
    //     msg: 'Network Error ${response.statusCode}, ${response.reasonPhrase}');

    print(
        '################## Network Error ${response.statusCode}, ${response.reasonPhrase}');

    throw Exception(
        'Network Error ${response.statusCode}, ${response.reasonPhrase}');
  }

  ResponseContentType parseContentType(http.Response response) {
    if (response.headers['content-type'] == null)
      return ResponseContentType.unkowen;
    switch (response.headers['content-type']
        .split(';')
        .first
        .toLowerCase()
        .trim()) {
      case 'application/json':
        return ResponseContentType.json;
      case 'text/plain':
        return ResponseContentType.text;
      default:
        return ResponseContentType.unkowen;
    }
  }

  bool _handelStreamedResponse(http.StreamedResponse response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    }

    // Fluttertoast.showToast(
    //     msg: 'Network Error ${response.statusCode}, ${response.reasonPhrase}');
    throw Exception(
        'Network Error ${response.statusCode}, ${response.reasonPhrase}');
  }
}

enum ResponseContentType {
  json,
  text,
  unkowen,
}
