import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class PasswordFormField extends HookWidget {
  const PasswordFormField({
    super.key,
    this.controller,
    this.hintText,

    this.onChanged,

    this.validator,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String?)? validator;
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
    final isObsureText = useState(true);

    return TextFormField(
      obscureText: isObsureText.value,
      focusNode: focusNode,
      autovalidateMode: autoValidateMode.value,
      onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: focusNode.hasFocus ? Colors.transparent : null,
        errorMaxLines: 2,
        hintText: hintText,

        suffixIcon: GestureDetector(
          onTap: () {
            isObsureText.value = !isObsureText.value;
          },
          child: Padding(
            padding: const EdgeInsets.all(7.5),
            child:
                isObsureText.value
                    ? Icon(Icons.visibility, color: Colors.black)
                    : Icon(Icons.visibility_off, color: Colors.black),
          ),
        ),
      ),
      validator: validator,
    );
  }
}
