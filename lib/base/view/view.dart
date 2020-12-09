import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rpg/base/view/view_model.dart';

abstract class View<T extends ViewModel> extends StatelessWidget {
  final T viewModel;

  View(T viewModel, {Key key})
      : assert(viewModel != null),
        viewModel = Get.isRegistered<T>() ? viewModel : Get.put<T>(viewModel),
        super(key: key);
}
