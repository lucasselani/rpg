import 'package:get/get.dart';
import 'package:rpg/base/view/view_state.dart';

class ViewModel extends GetxController {
  final Rx<ViewState> _state = IdleState().obs;
  ViewState get state => _state.value;
  set state(ViewState value) => _state.value = value;

  static T find<T extends ViewModel>() => Get.find();
}
