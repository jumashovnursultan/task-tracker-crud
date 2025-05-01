import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationCodePage extends HookConsumerWidget {
  const VerificationCodePage(this.phone, {super.key});

  final String phone;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Gap(30),
                    // Row(
                    //   children: [
                    //     SvgPicture.asset('assets/svg/arrow_back.svg'),
                    //     Text(
                    //       Strings.of(context).loginIn,
                    //       style: TextStyle(fontSize: 16),
                    //     ),
                    //   ],
                    // ),
                    Spacer(),
                    // Text('Enter code', style: TextStyle(fontSize: 26)),
                    // Gap(16),
                    // Text(
                    //   'We have sent a confirmation code to the number $phone',
                    //   style: TextStyle(fontSize: 16, color: Color(0xFF92918A)),
                    //   textAlign: TextAlign.center,
                    // ),
                    OtpFields(),
                    Spacer(),
                    // Text(
                    //   'We will send the code again in 43 seconds.',
                    //   style: TextStyle(fontSize: 16, color: Color(0xFF92918A)),
                    // ),
                    // Gap(16),
                    // Text('Help?', style: TextStyle(fontSize: 16)),
                    // Gap(32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OtpFields extends StatefulWidget {
  const OtpFields({super.key});

  @override
  State<OtpFields> createState() => _OtpFieldsState();
}

class _OtpFieldsState extends State<OtpFields> {
  final controllers = List.generate(4, (_) => TextEditingController());
  final focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < focusNodes.length; i++) {
      focusNodes[i].addListener(() => setState(() {}));
      controllers[i].addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) {
        return Container(
          width: 48,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: controllers[i],
            focusNode: focusNodes[i],

            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              hintText:
                  (focusNodes[i].hasFocus && controllers[i].text.isEmpty)
                      ? ''
                      : '•',

              filled: true,
              fillColor: Colors.transparent,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            onChanged: (value) {
              if (value.isNotEmpty && i < 3) {
                focusNodes[i + 1].requestFocus();
              } else if (value.isEmpty && i > 0) {
                focusNodes[i - 1].requestFocus();
              }
            },
          ),
        );
      }),
    );
  }
}
