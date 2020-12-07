import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpg/base/view/view_model.dart';

abstract class View<T extends ViewModel> extends StatelessWidget {
  final T viewModel;

  View(this.viewModel, {Key key})
      : assert(viewModel != null),
        super(key: key) {
    if (!Get.isRegistered<T>()) Get.put<T>(viewModel);
  }
}
