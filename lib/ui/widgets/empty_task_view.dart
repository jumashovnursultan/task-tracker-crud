import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyTaskView extends StatelessWidget {
  const EmptyTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle_outline,
          size: 80,
          color: Color(0xFFBDBDBD),
        ),
        const Gap(20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'У вас пока нет задач',
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
