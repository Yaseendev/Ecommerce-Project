import 'package:flutter/material.dart';
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

  @override
  void initState() {
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
                },
              ),
            ],
          ),
        ),
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
