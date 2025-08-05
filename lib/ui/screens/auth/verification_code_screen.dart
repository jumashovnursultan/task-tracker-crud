import 'dart:async';

import 'package:to_do/config/router/app_route.dart';
import 'package:to_do/helpers/toast_helper.dart';
import 'package:to_do/l10n/app_localizations.dart';
import 'package:to_do/providers/login_providers.dart';
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
        // context.go(Routes.tariffSelection());
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
                    Gap(16),
                    Text(
                      'If you don’t see the email, check your Spam folder.',
                      style: TextStyle(fontSize: 14, color: Color(0xFFB0AFAB)),
                      textAlign: TextAlign.center,
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
