library jsonp;

import 'dart:async';
import 'src/jsonp_impl.dart' as impl;

Future fetch(
    {required String uri,
    required String Function(String callback) uriGenerator}) {
  return impl.fetch(uri: uri, uriGenerator: uriGenerator);
}
