import 'package:flutter/foundation.dart';
import 'package:rpg/base/view/view_state.dart';

class ViewModel with ChangeNotifier {
  ViewState _state = IdleState();
  ViewState get state => _state;
  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  bool _mounted = true;
  bool get mounted => _mounted;

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (mounted) super.notifyListeners();
  }
}
