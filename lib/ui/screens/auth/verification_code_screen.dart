import 'dart:async';

import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/strings.dart';
import 'package:adhdo_it_mob/providers/login_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:pinput/pinput.dart';

class VerificationCodeScreen extends HookConsumerWidget {
  const VerificationCodeScreen(this.email, {super.key});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verifyCodeState = ref.watch(verifyCodeProvider);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final timeMinutes = useState(1);
    final timeSeconds = useState(00);
    final timer = useState<Timer?>(null);

    useEffect(() {
      if (timer.value?.isActive == true) return;
      timer.value = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timeSeconds.value > 0) {
          timeSeconds.value--;
        } else {
          if (timeMinutes.value == 0) {
            timer.cancel();
            return;
          } else {
            timeSeconds.value = 59;
          }

          timeMinutes.value--;
        }
      });
      return;
    }, [timeMinutes.value, timeSeconds.value]);

    ref.listen(verifyCodeProvider, (prevState, nextState) async {
      if (nextState.status.isError) {
        showToast(
          context,
          msg:
              nextState.error?.toString() ??
              Strings.of(context).somethingWentWrong,
          type: ToastificationType.error,
        );
      } else if (nextState.status.isSuccess) {
        context.go(Routes.intro());
      }
    });

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Gap(30),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/svg/arrow_back.svg'),
                          Text(
                            Strings.of(context).loginIn,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Text(
                      Strings.of(context).enterCode,
                      style: TextStyle(fontSize: 26),
                    ),
                    Gap(16),
                    Text(
                      Strings.of(context).weSentCode(email),
                      style: TextStyle(fontSize: 16, color: Color(0xFF92918A)),
                      textAlign: TextAlign.center,
                    ),
                    Gap(20),
                    if (!verifyCodeState.status.isLoading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            length: 4,
                            autofocus: true,

                            keyboardType: TextInputType.phone,
                            hapticFeedbackType: HapticFeedbackType.lightImpact,

                            onCompleted: (pin) {
                              ref
                                  .read(verifyCodeProvider.notifier)
                                  .codeVerify(email, pin);
                            },
                            separatorBuilder:
                                (index) => const SizedBox(width: 10),

                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,

                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            cursor: Container(
                              width: 1.5,
                              height: 22,
                              color: Theme.of(context).primaryColor,
                            ),
                            submittedPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            defaultPinTheme: PinTheme(
                              width: 56,
                              height: 56,
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(30, 60, 87, 1),
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SizedBox(
                        height: 30,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballPulseSync,
                          colors: [Colors.black],
                        ),
                      ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (timeMinutes.value == 0 && timeSeconds.value == 0) {
                          timeMinutes.value = 2;
                          timeSeconds.value = 00;
                          ref
                              .read(verifyCodeProvider.notifier)
                              .resendCode(email);
                        }
                      },
                      child: Text(
                        timeMinutes.value == 0 && timeSeconds.value == 0
                            ? Strings.of(context).resendCode
                            : '${Strings.of(context).weWillSendCode}'
                                ' ${timeMinutes.value < 10 ? '0' : ''}${timeMinutes.value.toString()}:'
                                '${timeSeconds.value < 10 ? '0' : ''}${timeSeconds.value.toString()}'
                                '.',
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              timeMinutes.value == 0 && timeSeconds.value == 0
                                  ? Color(0xFF9605AC)
                                  : Color(0xFF92918A),
                        ),
                      ),
                    ),

                    Gap(16),
                    Text(
                      '${Strings.of(context).help}?',
                      style: TextStyle(fontSize: 16),
                    ),
                    Gap(32),
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
