import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:renweather/app/modules/weather/domain/provider/get_cities_provider.dart';
import 'package:renweather/core/framework/base_notifier.dart';

import '../../domain/provider/persisted_locations_provider.dart';

class CitiesOptionPage extends HookConsumerWidget {
  const CitiesOptionPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final citiesProvider = ref.useProvider(getCitiesProvider);

    final dataStore = ref.watch(localCitiesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select cities to add to favorites",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: citiesProvider.when(
        done: (cities) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cities.length,
                  itemBuilder: (context, index) {
                    final cityModel = cities[index];
                    return GestureDetector(
                      onTap: () {
                        ref.read(localCitiesProvider.notifier).addRemoveCity(
                              cityModel.city,
                              LongLatit(
                                latitiude: cityModel.lat,
                                long: cityModel.long,
                              ),
                            );
                      },
                      child: ListTile(
                        trailing: dataStore.containsKey(cityModel.city)
                            ? const Icon(
                                Icons.check,
                              )
                            : null,
                        title: Text(
                          cityModel.city,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
        error: (error) {
          return Text("$error");
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
