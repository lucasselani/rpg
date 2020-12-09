import 'package:get/get.dart';
import 'package:rpg/base/view/view_state.dart';

abstract class ViewModel extends GetxController {
  final Rx<ViewState> _state = Rx(IdleState());
  ViewState get state => _state.value;
  set state(ViewState value) => _state.value = value;

  static T find<T extends ViewModel>() => Get.find();
}
