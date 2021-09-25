library jsonp.impl;

import 'dart:async';
import 'handlers.dart';

Future fetch(
    {required String uri,
    required String Function(String callback) uriGenerator}) {
  try {
    final Once once = Once();

    once.request(
        (String callback) => _generateUrl(uri, uriGenerator, callback));
    return once.future();
  } catch (e) {
    return Future.error(e);
  }
}

// Transforms the uri, uriGenerator and callback into the callable url.
String _generateUrl(String uri, String Function(String callback) uriGenerator,
    String callback) {
  if (uri == "" && uriGenerator == "") {
    throw ArgumentError("Missing Parameter: uri or uriGenerator required");
  }

  return uri != "" ? _addCallbackToUri(uri, callback) : uriGenerator(callback);
}

// Replaces any of the query values that are '?' with the callback name.
String _addCallbackToUri(String uri, String callback) {
  Uri parsed, updated;
  Map<String, String> query;
  int count = 0;

  parsed = Uri.parse(uri);
  query = <String, String>{};
  parsed.queryParameters.forEach((String key, String value) {
    if (value == '?') {
      query[key] = callback;
      count++;
    } else {
      query[key] = value;
    }
  });
  if (count == 0) {
    throw ArgumentError(
        "Missing Callback Placeholder: when providing a uri, at least one query parameter must have the ? value");
  }

  updated = Uri(
      scheme: parsed.scheme,
      userInfo: parsed.userInfo,
      host: parsed.host,
      port: parsed.port,
      path: parsed.path,
      fragment: parsed.fragment,
      queryParameters: query);

  return updated.toString();
}
