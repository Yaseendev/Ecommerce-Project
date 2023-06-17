import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';

enum ButtonState { idle, loading }

class AccountButton extends StatefulWidget {
  final VoidCallback onPress;
  final String label;
 final ButtonState? buttonState;
  const AccountButton({
    Key? key,
    required this.onPress,
    required this.label,
    this.buttonState,
  }) : super(key: key);

  @override
  State<AccountButton> createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  ButtonState? buttonState;
  bool isAnimating = true;

  @override
  void initState() {
    buttonState = widget.buttonState ?? ButtonState.idle; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isStretched = isAnimating || buttonState == ButtonState.idle;
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountLoading) {
          setState(() {
            buttonState = ButtonState.loading;
          });
        } else {
          setState(() {
            buttonState = ButtonState.idle;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: AnimatedContainer(
          width: buttonState == ButtonState.idle
              ? MediaQuery.of(context).size.width
              : 80,
          duration: const Duration(milliseconds: 250),
          onEnd: () => setState(() => isAnimating = !isAnimating),
          curve: Curves.easeIn,
          child: isStretched
              ? ElevatedButton(
                  child: Text(
                    widget.label.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () {
                    widget.onPress();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    )),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 12, horizontal: 35)),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(12),
                  child: Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                ),
        ),
      ),
    );
  }
}
