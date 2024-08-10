import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/weather_model.dart';

class WeatherInfoTileAtom extends StatelessWidget {
  final WeatherModel model;
  const WeatherInfoTileAtom({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF6082B6),
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${model.main.temp}°",
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            model.weather[0].description,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          LottieBuilder.asset(
            model.weather.first.animationIcon,
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }
}
