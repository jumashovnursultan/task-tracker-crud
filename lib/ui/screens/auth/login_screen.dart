import 'package:adhdo_it_mob/config/router/app_route.dart';
import 'package:adhdo_it_mob/helpers/toast_helper.dart';
import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:adhdo_it_mob/providers/login_providers.dart';
import 'package:adhdo_it_mob/ui/widgets/email_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();

    final loginState = ref.watch(loginProvider);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    ref.listen(loginProvider, (prevState, nextState) async {
      if (nextState.status.isError) {
        showToast(
          context,
          msg:
              nextState.error?.toString() ??
              Strings.of(context).somethingWentWrong,
          type: ToastificationType.error,
        );
      } else if (nextState.status.isSuccess) {
        context.push(Routes.verificationCode(), extra: emailController.text);
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(32),
                      Text(
                        Strings.of(context).welcomeTo,
                        style: TextStyle(fontSize: 32, height: 1.1),
                      ),
                      Text(
                        'ADHDo.it',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          height: 1.1,
                        ),
                      ),
                      Gap(20),
                      Image.asset('assets/images/logo.png'),
                      Gap(120),
                      Text(
                        Strings.of(context).loginToStart,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Gap(32),
                      EmailFormField(controller: emailController),

                      Gap(16),

                      Bounceable(
                        onTap: () async {
                          if (formKey.currentState!.validate() &&
                              !loginState.status.isLoading) {
                            ref
                                .read(loginProvider.notifier)
                                .login(emailController.text);
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 54,
                          width: double.infinity,

                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child:
                              loginState.status.isLoading
                                  ? SizedBox(
                                    height: 30,
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballPulseSync,
                                      colors: [Colors.white],
                                    ),
                                  )
                                  : Text(
                                    Strings.of(context).getCode,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                        ),
                      ),
                      Gap(30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
