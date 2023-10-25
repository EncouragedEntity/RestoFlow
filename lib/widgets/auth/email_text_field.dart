import 'package:flutter/material.dart';
import 'package:resto_flow/generated/l10n.dart';

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    super.key,
    required TextEditingController emailController,
  }) : _emailController = emailController;

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
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
        labelText: S.of(context).email,
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
        if (value == null || value.isEmpty) {
          return S.of(context).validation_email;
        }

        final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

        if (!emailRegExp.hasMatch(value)) {
          return S.of(context).validation_email_valid;
        }

        return null;
      },
    );
  }
}
