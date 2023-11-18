import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class CardDateDigitTextField extends StatelessWidget {
  const CardDateDigitTextField({
    super.key,
    required this.cardDateDigitController,
    required this.isMonth,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController cardDateDigitController;
  final bool isMonth;
  final FocusNode focusNode;
  final void Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        maxLength: 2,
        autocorrect: false,
        enableSuggestions: false,
        controller: cardDateDigitController,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: 3,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Theme.of(context).highlightColor,
          ),
          counterText: "",
          hintText: "00",
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
            return S.current.validation_card_number;
          }

          final int enteredValue = int.parse(value);

          if (isMonth) {
            if (enteredValue < 1 || enteredValue > 12) {
              return "";
            }
          } else {
            final currentYear = DateTime.now().year % 100;
            if (enteredValue < currentYear || enteredValue > currentYear + 80) {
              return "";
            }
          }

          return null;
        },
      ),
    );
  }
}
