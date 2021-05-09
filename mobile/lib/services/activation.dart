import 'package:flutter/material.dart';
import 'package:coupons/models/ActivationResult.dart';

enum ActivationState {
  active,
  notActive,
  unknown,
}

class Activation extends ChangeNotifier {
  ActivationResult _activation;

  ActivationState get isActive {
    if (_activation == null) {
      return ActivationState.unknown;
    }
    return _activation.active
        ? ActivationState.active
        : ActivationState.notActive;
  }

  String get until => _activation?.until ?? '';

  void setActivation(ActivationResult a) {
    _activation = a;
    notifyListeners();
  }
}
