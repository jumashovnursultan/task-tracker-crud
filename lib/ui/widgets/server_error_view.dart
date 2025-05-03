import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ServerErrorView extends StatelessWidget {
  const ServerErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.cloud_off, size: 80, color: Color(0xFFEF5350)),
        const Gap(20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Ошибка сервера. Попробуйте позже.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF92918A),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Gap(120),
      ],
    );
  }
}
