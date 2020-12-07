import 'package:get/get.dart';
import 'package:rpg/base/view/view_state.dart';

class ViewModel extends GetxController {
  ViewState _state = IdleState();
  ViewState get state => _state;

  static T find<T extends ViewModel>() => Get.find();

  void setState(ViewState state) {
    _state = state;
    update();
  }
}
