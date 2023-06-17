import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Cart/blocs/coupon_bloc/coupon_bloc.dart';

class CouponField extends StatefulWidget {
  final Function(String value) onApply;
  const CouponField({
    super.key,
    required this.onApply,
  });

  @override
  State<CouponField> createState() => _CouponFieldState();
}

class _CouponFieldState extends State<CouponField> {
  String value = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CouponBloc, CouponState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SizedBox(
            height: 48,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          width: 0,
                          color: Color(0xFFF6F6F6),
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Color(0xFFF6F6F6),
                      filled: true,
                      hintText: 'Have a coupon?',
                      labelText: 'Coupon',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabled: state is! CouponLoading,
                    ),
                    textAlignVertical: TextAlignVertical.bottom,
                    onSubmitted: (value) {
                      if (value.trim().isNotEmpty) widget.onApply(value.trim());
                    },
                    onChanged: (val) => value = val,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, bottom: 2),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.all(10)),
                    onPressed: () {
                      if (value.trim().isNotEmpty) widget.onApply(value.trim());
                    },
                    child: Center(
                      child: state is! CouponLoading
                          ? Icon(Icons.add_rounded)
                          : CircularProgressIndicator.adaptive(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
