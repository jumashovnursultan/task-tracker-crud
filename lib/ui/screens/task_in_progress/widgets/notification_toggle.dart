import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:gap/gap.dart';

class NotificationToggle extends HookWidget {
  const NotificationToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final isMuted = useState<bool?>(null);

    useEffect(() {
      FlutterVolumeController.getVolume(stream: AudioStream.notification).then((
        volume,
      ) {
        isMuted.value = volume == 0.0;
      });
      final listener = FlutterVolumeController.addListener((volume) {
        isMuted.value = volume == 0.0;
      }, stream: AudioStream.notification);
      return () {
        listener.cancel();
      };
    }, []);

    if (isMuted.value == null) {
      return const SizedBox();
    }

    return Column(
      spacing: 16,
      children: [
        Text(
          isMuted.value == true
              ? 'Notifications are off. Great! You’re in focus mode.'
              : 'Notifications are on. Turn them off to stay focused.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),

        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 84,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: const Color(0xFF4A4A4A),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildButton(
                isActive: isMuted.value!,
                color: Colors.yellow,
                iconPath: 'assets/svg/notifications_off.svg',
              ),
              _buildButton(
                isActive: !isMuted.value!,
                color: Colors.grey.shade400,
                iconPath: 'assets/svg/notifications_on.svg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required bool isActive,
    required Color color,
    required String iconPath,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 37,
      height: 24,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          color: Colors.black,
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
