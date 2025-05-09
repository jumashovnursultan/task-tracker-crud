import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditTaskImageSelector extends StatelessWidget {
  const EditTaskImageSelector({
    super.key,
    required this.selectedImage,
    required this.onClear,
  });

  final ValueNotifier<dynamic> selectedImage;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (selectedImage.value is File)
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.file(
                    selectedImage.value,
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                )
              else if (selectedImage.value is String)
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    selectedImage.value,
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                  ),
                ),
              const Gap(10),
              const Text(
                'Foto',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Bounceable(
            onTap: onClear,
            child: Container(
              height: 24,
              width: 24,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: SvgPicture.asset('assets/svg/cancel.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
