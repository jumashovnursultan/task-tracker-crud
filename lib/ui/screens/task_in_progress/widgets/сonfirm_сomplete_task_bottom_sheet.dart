import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CompleteTaskConfirmSheet extends StatelessWidget {
  const CompleteTaskConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(26),
                    Text(
                      'Are you sure you want to complete the task?\nIt will be deleted once completed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: Color.fromRGBO(238, 238, 238, 1),
                    ),
                    Gap(5),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: SizedBox(
                        height: 44,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'Complete the task',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(16),
                  ],
                ),
              ),
              Gap(8),
              Container(
                height: 51,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
