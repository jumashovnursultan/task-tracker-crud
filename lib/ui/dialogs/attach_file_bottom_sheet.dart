import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class AttachFileBottomSheet extends StatelessWidget {
  const AttachFileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 4),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 1.86,
                width: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF92918A),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const Gap(10),
              const Text(
                "Add file",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const Gap(16),
              _buildItem(
                context,
                icon: 'assets/svg/image.svg',
                title: 'Image',
                onTap: () => Navigator.pop(context, 'image'),
              ),
              const Gap(4),
              _buildItem(
                context,
                icon: 'assets/svg/camera.svg',
                title: 'Camera',
                onTap: () => Navigator.pop(context, 'camera'),
              ),
              const Gap(4),
              _buildItem(
                context,
                icon: 'assets/svg/attach.svg',
                title: 'File',
                onTap: () => Navigator.pop(context, 'file'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Bounceable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset(icon),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
