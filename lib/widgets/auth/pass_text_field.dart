import 'package:flutter/material.dart';
import 'package:resto_flow/generated/l10n.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required TextEditingController passController,
    TextEditingController? rePassController,
    required this.titleText,
  })  : _passController = passController,
        _rePassController = rePassController;

  final TextEditingController _passController;
  final TextEditingController? _rePassController;
  final String titleText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passController,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Theme.of(context).highlightColor,
        ),
        labelText: titleText,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
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

        if (value == null || value.isEmpty) {
          return S.of(context).validation_password;
        }

        if (value.length < 8) {
          return S.of(context).validation_password_valid;
        }

        return null;
      },
    );
  }
}
