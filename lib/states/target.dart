import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Target with ChangeNotifier, DiagnosticableTreeMixin {
  int _count = 0;
  final _config = {
    'id': 0,
    'title': 'test',
    'content': {'test': 123}
  };

  int get count => _count;
  Map get config => _config;

  void increment() {
    _count++;
    notifyListeners();
  }

  void changeTarget(String content) {
    _config['title'] = content;
    notifyListeners();
  }

  /// Makes `Target` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }
}
