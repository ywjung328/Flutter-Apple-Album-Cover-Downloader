library jsonp.handlers;

import 'dart:async';
import 'dart:html';
import 'dart:js' as js;

int _count = 0;

// Each call to this will return a different id. The return value can be used as the callback name.
String _generateId() {
  return "jsonp_receive_${_count++}";
}

abstract class CallbackHandler {
  final String callback;

  CallbackHandler(this.callback);

  void request(String Function(String callback) generator);

  void complete(js.JsObject result);

  void error(Event error);

  void dispose() {
    js.context.deleteProperty(callback);
  }
}

/**
 * This provides a one shot request as a Future.
 */
class Once extends CallbackHandler {
  final Completer _completer = Completer();
  final ScriptElement script = ScriptElement();

  Once() : super(_generateId()) {
    js.context[callback] = (result) {
      dispose();
      _completer.complete(result);
    };
    script.onError.listen(error);
  }

  Future future() => _completer.future;

  @override
  void request(String Function(String callback) generator) {
    script.src = generator(callback);
    document.body!.nodes.add(script);
  }

  @override
  void dispose() {
    super.dispose();
    script.remove();
  }

  @override
  void complete(js.JsObject result) {
    dispose();
    _completer.complete(result);
  }

  @override
  void error(e) {
    dispose();
    _completer.completeError(e);
  }
}
