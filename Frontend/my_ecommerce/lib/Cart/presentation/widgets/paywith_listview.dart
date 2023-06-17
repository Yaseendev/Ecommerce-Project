import 'package:flutter/material.dart';
import 'package:my_ecommerce/Utils/constants.dart';
import 'package:my_ecommerce/Utils/enums.dart';

class PaywithView extends StatefulWidget {
  final Function(PaymentMethod method) onSelect;
  const PaywithView({
    super.key,
    required this.onSelect,
  });

  @override
  State<PaywithView> createState() => _PaywithViewState();
}

class _PaywithViewState extends State<PaywithView> {
  PaymentMethod selectedMethod = PaymentMethod.cash;
  final GlobalKey<FormState> cardKey = GlobalKey<FormState>();
  // CreditCardModel creditCardInfo = CreditCardModel('', '', '', '', false);
  // late CreditCardModel temp;

  @override
  void initState() {
    // temp = creditCardInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          elevation: 2,
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<PaymentMethod>(
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 5,
                  leading: Icon(
                    Icons.credit_card_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Credit Card',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                value: PaymentMethod.creditCard,
                groupValue: selectedMethod,
                onChanged: (val) async {
                  // showModalBottomSheet(
                  //   context: context,
                  //   enableDrag: true,
                  //   isScrollControlled: true,
                  //   shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.vertical(
                  //     top: Radius.circular(20),
                  //   )),
                  //   builder: (context) {
                  //     return SingleChildScrollView(
                  //       child: Column(
                  //         // crossAxisAlignment: CrossAxisAlignment.start,
                  //         mainAxisSize: MainAxisSize.min,
                  //         //shrinkWrap: true,
                  //         children: [
                  //           ListTile(
                  //             leading: Icon(Icons.credit_card),
                  //             title: Text(
                  //               'Credit Card Info',
                  //               style: TextStyle(
                  //                 fontSize: 22,
                  //                 fontWeight: FontWeight.bold,
                  //               ),
                  //             ),
                  //           ),

                  //           Divider(),

                  //           // CreditCardForm(
                  //           //   formKey: cardKey,
                  //           //   cardNumber: creditCardInfo.cardNumber,
                  //           //   expiryDate: creditCardInfo.expiryDate,
                  //           //   cardHolderName: creditCardInfo.cardHolderName,
                  //           //   cvvCode: creditCardInfo.cvvCode,
                  //           //   onCreditCardModelChange: (CreditCardModel data) {
                  //           //     temp = data;
                  //           //   },
                  //           //   themeColor: Theme.of(context).primaryColor,
                  //           //   cardHolderDecoration: InputDecoration(
                  //           //     labelText: 'Card Holder',
                  //           //     border: OutlineInputBorder(
                  //           //       borderRadius: BorderRadius.circular(20),
                  //           //     ),
                  //           //   ),
                  //           //   cardNumberDecoration: InputDecoration(
                  //           //     border: OutlineInputBorder(
                  //           //       borderRadius: BorderRadius.circular(20),
                  //           //     ),
                  //           //     labelText: 'Number',
                  //           //     hintText: 'XXXX XXXX XXXX XXXX',
                  //           //   ),
                  //           //   expiryDateDecoration: InputDecoration(
                  //           //     border: OutlineInputBorder(
                  //           //       borderRadius: BorderRadius.circular(20),
                  //           //     ),
                  //           //     labelText: 'Expired Date',
                  //           //     hintText: 'XX/XX',
                  //           //   ),
                  //           //   cvvCodeDecoration: InputDecoration(
                  //           //     border: OutlineInputBorder(
                  //           //       borderRadius: BorderRadius.circular(20),
                  //           //     ),
                  //           //     labelText: 'CVV',
                  //           //     hintText: 'XXX',
                  //           //   ),
                  //           // ),
                  //           // StripeLib.CardFormField(
                  //           //   style: StripeLib.CardFormStyle(
                  //           //     textColor: Colors.black,
                  //           //     placeholderColor: Colors.black,
                  //           //   ),
                  //           //   controller: StripeLib.CardFormEditController(),
                  //           // ),
                  //           SizedBox(
                  //             width: MediaQuery.of(context).size.width,
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: ElevatedButton(
                  //                 onPressed: () {
                  //                   if (cardKey.currentState!.validate()) {
                  //                     setState(() {
                  //                       //creditCardInfo = temp;
                  //                       selectedMethod =
                  //                           PaymentMethod.creditCard;
                  //                     });
                  //                     Navigator.of(context).pop();
                  //                   }
                  //                 },
                  //                 style: ElevatedButton.styleFrom(
                  //                   alignment: Alignment.center,
                  //                   padding: const EdgeInsets.all(14),
                  //                   shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(16),
                  //                   ),
                  //                 ),
                  //                 child: Text(
                  //                   'Save Card',
                  //                   style: TextStyle(
                  //                     fontSize: 18,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: MediaQuery.of(context).viewInsets.bottom,
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );
                  // await StripeLib.Stripe.instance.initPaymentSheet(
                  //     paymentSheetParameters: StripeLib.SetupPaymentSheetParameters(
                  //   style: ThemeMode.dark,
                  // ));
                  // StripeLib.Stripe.instance.presentPaymentSheet();
                  // final paymentMethod = await StripeLib.Stripe.instance
                  //     .createPaymentMethod(StripeLib.PaymentMethodParams.card(
                  //         paymentMethodData: StripeLib.PaymentMethodData()));

                  // setState(() {
                  //   selectedMethod = val!;
                  // });
                  // widget.onSelect(val!);
                },
              ),
              // selectedMethod == PaymentMethod.creditCard
              //     ? CreditCardWidget(
              //         width: MediaQuery.of(context).size.width * .55,
              //         height: 130,
              //         cardNumber: creditCardInfo.cardNumber,
              //         expiryDate: creditCardInfo.expiryDate,
              //         cardHolderName: creditCardInfo.cardHolderName,
              //         cvvCode: creditCardInfo.cvvCode,
              //         showBackView: false,
              //         onCreditCardWidgetChange: (CreditCardBrand data) {},
              //         cardType: CardType.visa,
              //       )
              //     : Container(),
            ],
          ),
        ),
        // CreditCardWidget(
        //   cardNumber: '1234567890',
        //   expiryDate: '',
        //   cardHolderName: 'cardHolderName',
        //   cvvCode: 'cvvCode',
        //   showBackView: false,
        //   onCreditCardWidgetChange: (p0) {},
        // ),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: RadioListTile<PaymentMethod>(
            title: ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 5,
              leading: Icon(
                Icons.payments_outlined,
                color: Colors.black,
              ),
              title: Text(
                'Cash',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            value: PaymentMethod.cash,
            groupValue: selectedMethod,
            onChanged: (val) {
              setState(() {
                selectedMethod = val!;
              });
              widget.onSelect(val!);
            },
          ),
        ),
      ],
    );
  }
}
