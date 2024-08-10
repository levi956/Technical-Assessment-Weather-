import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ForecastAtom extends StatelessWidget {
  final String title;
  final String data;
  final IconData icon;
  const ForecastAtom({
    super.key,
    required this.data,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: const Color(0xFF6082B6),
          child: PhosphorIcon(
            icon,
            size: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: Color(0xFF71797E),
              ),
            ),
            Text(
              data,
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        )
      ],
    );
  }
}
