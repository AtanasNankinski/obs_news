import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_controller.g.dart';

@riverpod
class SplashController extends _$SplashController {
  @override
  Raw<bool>build() {
    return false;
  }

  void splashIsDisplayed() {
    state = true;
  }
}