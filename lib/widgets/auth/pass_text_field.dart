import 'package:flutter/material.dart';
import 'package:resto_flow/generated/l10n.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required TextEditingController passController,
    TextEditingController? rePassController,
    required this.titleText,
    this.allowEmpty = false,
  })  : _passController = passController,
        _rePassController = rePassController;

  final TextEditingController _passController;
  final TextEditingController? _rePassController;
  final String titleText;
  final bool allowEmpty;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      controller: _passController,
      style: const TextStyle(
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Theme.of(context).highlightColor,
        ),
        hintText: titleText,
        hintStyle: TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          color: Theme.of(context).highlightColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).highlightColor,
          ),
        ),
      ),
      validator: (value) {
        if (_rePassController != null) {
          if (value == null || value.isEmpty) {
            return S.of(context).validation_re_password;
          }

          if (value != _rePassController?.text) {
            return S.of(context).validation_re_password_valid;
          }
        }

        if (!allowEmpty) {
          if (value == null || value.isEmpty) {
            return S.of(context).validation_password;
          }
        }

        if (value == null || value.isNotEmpty && value.length < 8) {
          return S.of(context).validation_password_valid;
        }

        return null;
      },
    );
  }
}
