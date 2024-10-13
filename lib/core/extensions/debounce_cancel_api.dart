import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_riverpod/core/locator.dart';
import 'package:pokemon_riverpod/core/network/api.dart';

extension DebounceCancelApi on Ref {
  Future<Api> getDebouncedApi([Duration? duration]) async {
    var didDispose = false;
    // ref.onDispose == when the provider is disposed
    onDispose(() => didDispose  = true);

    // debouncing (delay api call by 500ms)
    await Future.delayed(duration ?? const Duration(milliseconds: 500));

    // this means that the provider was disposed during the 500ms delay
    // we throw an exception so we don't need to make api call anymore
    if (didDispose) {
      throw ("Cancelled");
    }

    Api _api = locator.get<Api>();
    onDispose(_api.close);
    return _api;
  }
}