import 'dart:io';

import 'package:adhdo_it_mob/ui/dialogs/attach_file_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditTaskImageSelector extends StatelessWidget {
  const EditTaskImageSelector({super.key, required this.selectedImage});

  final ValueNotifier<dynamic> selectedImage;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        final image = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          builder: (_) => AttachFileBottomSheet(),
        );

        if (image is File) {
          selectedImage.value = image;
        }
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color:
              selectedImage.value != null
                  ? const Color.fromRGBO(245, 245, 245, 1)
                  : null,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.only(
          right: 16,
          left: selectedImage.value != null ? 16 : 6,
        ),
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
                  )
                else
                  SvgPicture.asset('assets/svg/attach.svg'),
                selectedImage.value != null ? const Gap(10) : Gap(0.1),
                const Text(
                  'Foto',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            if (selectedImage.value != null)
              Bounceable(
                onTap: () {
                  selectedImage.value = null;
                },
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
              )
            else
              SvgPicture.asset('assets/svg/arrow_forward.svg'),
          ],
        ),
      ),
    );
  }
}
