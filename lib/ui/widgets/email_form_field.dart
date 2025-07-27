import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EmailFormField extends HookWidget {
  const EmailFormField({super.key, required this.controller, this.onChanged});

  final TextEditingController controller;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final autoValidateMode = useState(AutovalidateMode.disabled);

    useEffect(() {
      void onFocusChange() {
        if (!focusNode.hasFocus) {
          autoValidateMode.value = AutovalidateMode.always;
        }
      }

      focusNode.addListener(onFocusChange);
      return () => focusNode.removeListener(onFocusChange);
    }, [focusNode]);

    return TextFormField(
      focusNode: focusNode,
      controller: controller,

      validator: (value) {
        if (value!.isEmpty) {
          return Strings.of(context).enterYourEmail;
        }
        if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
          return Strings.of(context).enterValidEmailAddress;
        }
        return null;
      },
      autovalidateMode: autoValidateMode.value,
      inputFormatters: [],
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: Strings.of(context).enterYourEmail,
        filled: true,
        fillColor: focusNode.hasFocus ? Colors.transparent : null,
        errorMaxLines: 2,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
