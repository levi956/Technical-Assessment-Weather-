import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseNotifier<T> extends Notifier<NotifierState<T>> {
  @override
  NotifierState<T> build() => const NotifierState();

  void init(bool reInit) {
    if (_hasInitialized && !reInit) return;
    _hasInitialized = true;
    onInit();
  }

  bool _hasInitialized = false;

  void onInit() {}

  void setLoading() {
    state = const NotifierState(status: NotifierStatus.loading);
  }

  void setIdle() {
    state = const NotifierState(status: NotifierStatus.idle);
  }

  void setData(T data) {
    state = NotifierState(status: NotifierStatus.done, data: data);
  }

  void setError(String message) {
    state = NotifierState(
      status: NotifierStatus.error,
      message: message,
    );
  }
}

class NotifierState<T> {
  final T? data;
  final NotifierStatus status;
  final String? message;
  const NotifierState({
    this.data,
    this.status = NotifierStatus.idle,
    this.message,
  });

  bool get isDone => status == NotifierStatus.done;
  bool get isLoading => status == NotifierStatus.loading;
  bool get isIdle => status == NotifierStatus.idle;
  bool get isError => status == NotifierStatus.error;

  Widget when({
    required Widget Function(T data) done,
    required Widget Function(String? message) error,
    required Widget Function() loading,
    Widget Function()? idle,
  }) {
    switch (status) {
      case NotifierStatus.loading:
        {
          return loading();
        }
      case NotifierStatus.idle:
        {
          if (idle == null) {
            return const SizedBox();
          }
          return idle();
        }
      case NotifierStatus.done:
        {
          return done(data as T);
        }
      case NotifierStatus.error:
        {
          return error(message);
        }
    }
  }
}

enum NotifierStatus { loading, idle, done, error }

NotifierState<T> notifyData<T>({required T? value}) {
  return NotifierState<T>(
    status: NotifierStatus.done,
    data: value,
  );
}

NotifierState<T> notifyError<T>({required String error}) {
  return NotifierState<T>(
    status: NotifierStatus.error,
    message: error,
  );
}

typedef FutureNotifierState<T> = Future<NotifierState<T>>;

extension Hook on WidgetRef {
  NotifierState<R> useProvider<R, T extends BaseNotifier<R>>(
    NotifierProvider<T, NotifierState<R>> provider, {
    bool reInit = false,
  }) {
    useEffect(() {
      final timer = Timer(
        Duration.zero,
        () {
          read(provider.notifier).init(reInit);
        },
      );
      return () => timer.cancel();
    }, []);
    return watch(provider);
  }
}
