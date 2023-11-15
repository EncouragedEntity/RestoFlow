import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resto_flow/generated/l10n.dart';

import '../../services/card_number_formatter.dart';

class CardDigitsTextField extends StatelessWidget {
  const CardDigitsTextField({
    super.key,
    required TextEditingController cardDigitsController,
  }) : _cardDigitsController = cardDigitsController;

  final TextEditingController _cardDigitsController;

  final separator = " ";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 364,
      child: TextFormField(
        maxLength: 20,
        controller: _cardDigitsController,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: 2,
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9$separator]")),
          MaskedTextInputFormatter(
            mask: "xxxx xxxx xxxx xxxx",
            separator: separator,
          ),
        ],
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Theme.of(context).highlightColor,
          ),
          counterText: "",
          hintText: "0000 0000 0000 0000",
          labelText: S.current.card_number,
          labelStyle: TextStyle(
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
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.red),
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

          final cardDigitsRegExp =
              RegExp(r'(\d{4}[-. ]?){4}|\d{4}[-. ]?\d{6}[-. ]?\d{5}');

          if (!cardDigitsRegExp.hasMatch(value)) {
            return S.of(context).validation_email_valid;
          }

          return null;
        },
      ),
    );
  }
}
