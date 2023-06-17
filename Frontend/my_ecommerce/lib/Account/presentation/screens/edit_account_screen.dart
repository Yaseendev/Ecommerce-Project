import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:my_ecommerce/Account/blocs/account_bloc/account_bloc.dart';
import 'package:my_ecommerce/Account/blocs/account_info_bloc/account_info_bloc.dart';
import 'package:my_ecommerce/Account/data/models/name.dart';
import 'package:my_ecommerce/Account/data/models/user.dart';
import 'package:my_ecommerce/Utils/constants.dart';

class EditAccountScreen extends StatefulWidget {
  final User user;
  const EditAccountScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String firstName = '';
  String lastName = '';

  @override
  void initState() {
    email = widget.user.email;
    firstName = widget.user.name.first;
    lastName = widget.user.name.last;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountInfoBloc, AccountInfoState>(
      listener: (context, state) {
        if (state is AccountInfoError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                state.msg ?? '',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AccountInfoNoInternet) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.error,
                color: Colors.white,
              ),
              title: Text(
                'No Internet Connection',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            duration: const Duration(seconds: 2),
          ));
        } else if (state is AccountInfoEdited) {
          context
              .read<AccountBloc>()
              .add(LoadUserProfileEvent(user: state.user));
          Fluttertoast.showToast(
            msg: 'Your account has been updated successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.NONE,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Account',
            style: TextStyle(
              color: AppColors.PRIMARY_COLOR,
            ),
          ),
          elevation: 1,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          centerTitle: true,
          leading: BackButton(
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'First Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      hintText: 'First Name',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    initialValue: firstName,
                    onChanged: (value) => firstName = value,
                    validator: (value) {
                      return value!.trim().isEmpty ? 'Name is required' : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Last Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      hintText: 'Last Name',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    initialValue: lastName,
                    onChanged: (value) => lastName = value,
                    validator: (value) {
                      return value!.trim().isEmpty ? 'Name is required' : null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'E-mail',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100)),
                      hintText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    //autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    initialValue: email,
                    onChanged: (value) => email = value,
                    validator: (value) {
                      return !GetUtils.isEmail(value ?? '')
                          ? 'Please enter a valid email'
                          : null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<AccountInfoBloc, AccountInfoState>(
              builder: (context, state) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    maximumSize: Size.fromHeight(55),
                  ),
                  onPressed: state is! AccountInfoLoading
                      ? () {
                          context.read<AccountInfoBloc>().add(EditAccount(
                                  user: widget.user.copyWith(
                                email: email,
                                name: Name(
                                  first: firstName,
                                  last: lastName,
                                ),
                              )));
                        }
                      : null,
                  child: state is! AccountInfoLoading
                      ? const Text(
                          'Update Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
