import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TimeAtom extends StatelessWidget {
  final String header;
  final IconData icon;
  final String time;
  const TimeAtom({
    super.key,
    required this.header,
    required this.icon,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              header,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF71797E),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFF6082B6),
              child: PhosphorIcon(
                icon,
                size: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
