// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:resto_flow/models/payment/payment_result.dart';
import 'package:resto_flow/repositories/order_repository.dart';
import 'package:resto_flow/repositories/payment_repository.dart';
import 'package:resto_flow/repositories/user_repository.dart';
import 'package:resto_flow/services/stompsocket_service.dart';
import 'package:resto_flow/widgets/auth/email_text_field.dart';
import 'package:resto_flow/widgets/checkout/card_cvv_text_field.dart';
import 'package:resto_flow/widgets/checkout/card_digits_text_field.dart';

import '../generated/l10n.dart';
import '../models/payment/card_details.dart';
import '../widgets/checkout/card_date_digit_text_field.dart';
import '../widgets/checkout/desired_price_text_field.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({
    super.key,
    required this.isAuthenticated,
    required this.context,
  });

  final bool isAuthenticated;
  final BuildContext context;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cardDigitsController = TextEditingController();
  final TextEditingController _cardCvvController = TextEditingController();
  final TextEditingController _cardExpMonthController = TextEditingController();
  final TextEditingController _cardExpYearController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late final FocusNode _cardDigitsFocusNode;
  late final FocusNode _cardExpMonthFocusNode;
  late final FocusNode _cardExpYearFocusNode;
  late final FocusNode _cardCvvFocusNode;

  final int digitsMax = 20;
  final int dateMax = 2;

  bool payPartially = false;
  bool sendReceipt = true;
  bool saveCardDetails = false;

  bool _isProcessing = false;

  final _formKey = GlobalKey<FormState>();

  void setCardData() async {
    if (await PaymentRepository().areDetailsSaved) {
      final details = (await PaymentRepository().loadDetails)!;

      _cardDigitsController.text = details.digits;
      _cardCvvController.text = details.cvv;
      _cardExpMonthController.text = details.expMonth;
      _cardExpYearController.text = details.expYear;
    }
    _priceController.text =
        OrderRepository().currentOrder!.sumToPay.toStringAsFixed(2);
  }

  @override
  void initState() {
    setCardData();

    super.initState();

    _cardDigitsFocusNode = FocusNode();
    _cardExpMonthFocusNode = FocusNode();
    _cardExpYearFocusNode = FocusNode();
    _cardCvvFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _cardDigitsFocusNode.dispose();
    _cardExpMonthFocusNode.dispose();
    _cardExpYearFocusNode.dispose();
    _cardCvvFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        StompSocketService.instance!.sendMockRequest();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.checkout,
            style: const TextStyle(
              fontSize: 27,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: screenHeight - 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      textDirection: TextDirection.ltr,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withGreen(90),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CardDigitsTextField(
                                  cardDigitsController: _cardDigitsController,
                                  focusNode: _cardDigitsFocusNode,
                                  onChanged: (value) {
                                    if ((value.length + 1) == digitsMax) {
                                      _cardExpMonthFocusNode.requestFocus();
                                    }
                                  },
                                  maxLength: digitsMax,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  S.current.expiration_date,
                                  style: TextStyle(
                                      color: Theme.of(context).highlightColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CardDateDigitTextField(
                                          isMonth: true,
                                          cardDateDigitController:
                                              _cardExpMonthController,
                                          focusNode: _cardExpMonthFocusNode,
                                          onChanged: (value) {
                                            if (value.length == dateMax) {
                                              _cardExpYearFocusNode
                                                  .requestFocus();
                                            }
                                          },
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "/",
                                          style: TextStyle(
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CardDateDigitTextField(
                                          isMonth: false,
                                          cardDateDigitController:
                                              _cardExpYearController,
                                          focusNode: _cardExpYearFocusNode,
                                          onChanged: (value) {
                                            if (value.length == dateMax) {
                                              _cardCvvFocusNode.requestFocus();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    CardCvvTextField(
                                      cardCvvController: _cardCvvController,
                                      focusNode: _cardCvvFocusNode,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder(
                              future: PaymentRepository().areDetailsSaved,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data != null &&
                                      snapshot.data == false) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: saveCardDetails,
                                          onChanged: (value) {
                                            setState(() {
                                              saveCardDetails = value!;
                                            });
                                          },
                                        ),
                                        Text(S.current.want_to_save_card),
                                      ],
                                    );
                                  }
                                }
                                return Container();
                              },
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: payPartially,
                                  onChanged: (value) {
                                    setState(() {
                                      payPartially = value!;
                                    });
                                  },
                                ),
                                Text(S.current.pay_partially),
                              ],
                            ),
                            if (payPartially)
                              DesiredPriceTextField(
                                priceController: _priceController,
                              ),
                            if (widget.isAuthenticated == false)
                              Row(
                                children: [
                                  Checkbox(
                                    value: sendReceipt,
                                    onChanged: (value) {
                                      setState(() {
                                        sendReceipt = value!;
                                      });
                                    },
                                  ),
                                  Text(S.current.send_reciept),
                                ],
                              ),
                            if (!widget.isAuthenticated && sendReceipt)
                              EmailTextField(emailController: _emailController),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        !_isProcessing
                            ? ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: SizedBox(
                                  width: 329,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });
                                      if (_formKey.currentState!.validate()) {
                                        final payRep = PaymentRepository();
                                        final digits = _cardDigitsController
                                            .text
                                            .replaceAll(" ", "");
                                        final cvv = _cardCvvController.text;
                                        final expYear =
                                            _cardExpYearController.text;
                                        final expMonth =
                                            _cardExpMonthController.text;
                                        final email = _emailController
                                                .text.isNotEmpty
                                            ? _emailController.text
                                            : UserRepository.currentUser?.email;
                                        final price = double.tryParse(
                                            _priceController.text);

                                        CardDetails details = CardDetails(
                                          digits: digits,
                                          cvv: cvv,
                                          expMonth: expMonth,
                                          expYear: expYear,
                                        );

                                        if (saveCardDetails) {
                                          payRep.saveDetails(details);
                                        }

                                        final result = await PaymentRepository()
                                            .payTheCheck(
                                          details,
                                          email,
                                          UserRepository.currentUser?.id,
                                          !payPartially
                                              ? OrderRepository()
                                                  .currentOrder!
                                                  .sumToPay
                                              : price ?? 0.0,
                                        );

                                        if (result == PaymentResult.success) {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  S.current.payment_successful),
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .clearSnackBars();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  S.current.payment_failure),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }

                                        Navigator.of(context).pop();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      S.current.pay,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : const CircularProgressIndicator(),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
