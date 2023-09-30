import 'package:flutter_riverpod/flutter_riverpod.dart';

final slelectedSizeProvider =
    StateNotifierProvider<SelectedSizedNotifier, String>((ref) {
  return SelectedSizedNotifier();
});

class SelectedSizedNotifier extends StateNotifier<String> {
  SelectedSizedNotifier() : super("");

  void selSelectedSize(String size) {
    state = size;
  }
}
