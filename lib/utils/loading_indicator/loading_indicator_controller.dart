import 'package:flutter/cupertino.dart';

import 'default_loading_indicator.dart';

abstract class LoadingIndicatorController {
  bool get isShowing;

  void showLoadingState(BuildContext context);

  void hideLoadingState();
}

class LoadingIndicatorControllerImpl implements LoadingIndicatorController {
  OverlayEntry? _loadingOverlay;

  bool _isShowing = false;

  @override
  bool get isShowing => _isShowing;

  OverlayEntry _createLoadingOverlay() {
    return OverlayEntry(builder: (context) => DefaultLoadingIndicator());
  }

  @override
  void showLoadingState(BuildContext context) {
    if (_isShowing) return;

    final entry = _createLoadingOverlay();
    _loadingOverlay = entry;
    Overlay.of(context)?.insert(entry);
    _isShowing = true;
  }

  @override
  void hideLoadingState() {
    if (!_isShowing) return;

    _loadingOverlay?.remove();
    _isShowing = false;
  }
}
