import 'package:adhdo_it_mob/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneFormField extends HookWidget {
  const PhoneFormField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final autoValidateMode = useState(AutovalidateMode.disabled);

    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
      mask: '+#',
      filter: {"#": RegExp(r'[0-9]')},
    );

    void updateMask(String value) {
      if (value.startsWith('+7')) {
        maskFormatter.updateMask(mask: '+# ### ### ## ##');
      } else if (value.startsWith('+9')) {
        maskFormatter.updateMask(mask: '+### ### ### ###');
      } else {
        maskFormatter.updateMask(mask: '+##################');
      }
    }

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
          return Strings.of(context).enterPhoneNumber;
        }
        if (value.startsWith('+7')) {
          if (value.contains(' ') ? value.length != 16 : value.length != 12) {
            return Strings.of(context).numberIsNotLong;
          }
        } else if (value.startsWith('+996')) {
          if (value.contains(' ') ? value.length != 16 : value.length != 13) {
            return Strings.of(context).numberIsNotLong;
          }
        } else {
          return Strings.of(context).youCanEnterOnlyRussianOrKyrgyzNumbers;
        }
        return null;
      },
      autovalidateMode: autoValidateMode.value,
      inputFormatters: [maskFormatter],

      onChanged: (value) {
        updateMask(value);
        if (value.isEmpty) {
          maskFormatter.updateMask(mask: '+#');
        }
      },
      decoration: InputDecoration(
        hintText: Strings.of(context).enterPhoneNumber,
        filled: true,
        fillColor: focusNode.hasFocus ? Colors.transparent : null,
        errorMaxLines: 2,
      ),
      keyboardType: TextInputType.phone,
    );
  }
}
