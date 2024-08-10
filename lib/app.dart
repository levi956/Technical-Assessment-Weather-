import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/presentation/pages/homepage.dart';
import 'package:renweather/core/core.dart';

import 'app/modules/weather/domain/provider/get_cities_provider.dart';
import 'app/modules/weather/domain/provider/persisted_locations_provider.dart';

class App extends HookConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _ = ref.useProvider(getCitiesProvider);
    ref.watch(localCitiesProvider);

    //
    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return const Homepage();
          }),
        );
      });
      return null;
    }, []);
    return const Scaffold();
  }
}
