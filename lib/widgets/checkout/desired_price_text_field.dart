import 'package:flutter/material.dart';
import 'package:resto_flow/generated/l10n.dart';

class DesiredPriceTextField extends StatelessWidget {
  const DesiredPriceTextField({
    super.key,
    required TextEditingController priceController,
  }) : _priceController = priceController;

  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 364,
      child: TextFormField(
        maxLength: 6,
        autocorrect: false,
        enableSuggestions: false,
        controller: _priceController,
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
          labelText: S.current.desired_price,
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
          return null;
        },
      ),
    );
  }
}
