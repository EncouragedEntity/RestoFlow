import 'package:flutter/material.dart';

class CardCvvTextField extends StatelessWidget {
  const CardCvvTextField({
    super.key,
    required TextEditingController cardCvvController,
    required this.focusNode,
  }) : _cardCvvController = cardCvvController;

  final TextEditingController _cardCvvController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: TextFormField(
        focusNode: focusNode,
        obscureText: true,
        obscuringCharacter: "*",
        maxLength: 3,
        autocorrect: false,
        enableSuggestions: false,
        controller: _cardCvvController,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: 5,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Theme.of(context).highlightColor,
          ),
          counterText: "",
          hintText: "000",
          labelText: "CVV",
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
            return "";
          }

          final cardCvvRegExp = RegExp(r'^\d{3}$');

          if (!cardCvvRegExp.hasMatch(value)) {
            return "";
          }

          return null;
        },
      ),
    );
  }
}
