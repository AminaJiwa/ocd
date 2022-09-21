import 'package:flutter/material.dart' show BuildContext, ModalRoute;

extension GetArgument on BuildContext {
  T? getArgument<T>() {
    final modalRoute = ModalRoute.of(this);
    if (modalRoute != null) {
      final args = modalRoute.settings.arguments;
      //if we could grab the arguments from ModalRoute and if they are the type
      //that we are asking it to extract then we are going to give it back
      //otherwise it will fall through to just return null
      if (args != null && args is T) {
        return args as T;
      }
    }
    return null;
  }
}
