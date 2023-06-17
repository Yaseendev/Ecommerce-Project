import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Account/data/models/name.dart';
import 'account_button.dart';

class SingupForm extends StatefulWidget {
  const SingupForm({super.key});

  @override
  State<SingupForm> createState() => _SingupFormState();
}

class _SingupFormState extends State<SingupForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String firstName = '';
  String lastName = '';
  String password = '';
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    hintText: 'First Name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  onChanged: (value) => firstName = value,
                  validator: (value) {
                    return value!.trim().isEmpty ? 'Name is required' : null;
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100)),
                    hintText: 'Last Name',
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  onChanged: (value) => lastName = value,
                  validator: (value) {
                    return value!.trim().isEmpty ? 'Name is required' : null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              hintText: 'E-mail',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            //autofocus: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            maxLines: 1,
            onChanged: (value) => email = value,
            validator: (value) {
              return !GetUtils.isEmail(value ?? '')
                  ? 'Please enter a valid email'
                  : null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icon(Icons.password),
              suffixIcon: passwordVisible
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () => setState(() {
                        passwordVisible = false;
                      }),
                    )
                  : IconButton(
                      onPressed: () => setState(() {
                        passwordVisible = true;
                      }),
                      icon: const Icon(Icons.visibility_off),
                    ),
            ),
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            onChanged: (value) => password = value,
            obscureText: passwordVisible,
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? value.trim().length >= 8
                      ? null
                      : 'Password must be longer than 7 characters'
                  : 'This field is required';
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
              hintText: 'Confirm Password',
              labelText: 'Confirm Password',
              prefixIcon: const Icon(Icons.password),
              suffixIcon: passwordVisible
                  ? IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () => setState(() {
                        passwordVisible = false;
                      }),
                    )
                  : IconButton(
                      onPressed: () => setState(() {
                        passwordVisible = true;
                      }),
                      icon: const Icon(Icons.visibility_off),
                    ),
            ),
            keyboardType: TextInputType.visiblePassword,
            maxLines: 1,
            obscureText: passwordVisible,
            validator: (value) {
              return value!.trim().isNotEmpty
                  ? value == password
                      ? null
                      : 'Passwords must be identical'
                  : 'This field is required';
            },
          ),
          SizedBox(height: 20),
          AccountButton(
            label: 'Sign Up',
            onPress: () {
              FocusScope.of(context).unfocus();
              if (_formKey.currentState!.validate())
                context.read<AccountBloc>().add(SingUpEvent(
                      email: email,
                      name: Name(first: firstName, last: lastName),
                      password: password,
                    ));
            },
          ),
        ],
      ),
    );
  }
}
