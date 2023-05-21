import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:traveller/components/loader.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/states/auth/auth.provider.dart';
import 'package:traveller/utils/colors.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8,
      errorText: 'Password must be at least 8 characters long'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  PatternValidator(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorText: 'Invalid Email')
]);

final nameValidator = MultiValidator([
  RequiredValidator(errorText: 'Full name is required'),
  MinLengthValidator(3, errorText: 'Name must be at least 3 characters long'),
]);

class Registration extends ConsumerStatefulWidget {
  final Function toggleView;
  Registration({required this.toggleView});
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends ConsumerState<Registration> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _loadingState = StateProvider<bool>((ref) => false);
  final _hidePasswordProvider = StateProvider<bool>((ref) => false);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_loadingState);
    final hide = ref.watch(_hidePasswordProvider);

    return SafeArea(
      child: Container(
        color: AppColors.primary,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    "images/logo.png",
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 50,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            blurRadius: 50.0,
                            spreadRadius: 50.0,
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Email",
                                prefixIcon: Icon(
                                  Icons.email,
                                ),
                              ),
                              validator: emailValidator,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _nameController,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Fullname",
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                              ),
                              validator: nameValidator,
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: hide,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    hide
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(_hidePasswordProvider.notifier)
                                        .state = !hide;
                                  },
                                ),
                              ),
                              validator: passwordValidator,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: hide,
                              decoration: textInputDecoration.copyWith(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    hide
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    ref
                                        .read(_hidePasswordProvider.notifier)
                                        .state = !hide;
                                  },
                                ),
                              ),
                              validator: (String? value) {
                                if (value?.isEmpty ?? true)
                                  return 'Confirm password is required';
                                else if (value != _passwordController.text)
                                  return 'Confirm password and password do not match';
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                backgroundColor: Colors.black45,
                              ),
                              child: isLoading
                                  ? Loader()
                                  : Icon(
                                      Icons.arrow_forward,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                              onPressed: () async {
                                if (isLoading) return;

                                ref.read(_loadingState.notifier).state = true;

                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await ref.read(authProvider.notifier).signUp(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                        name: _nameController.text.trim(),
                                        passwordConfirmation:
                                            _confirmPasswordController.text
                                                .trim(),
                                      );
                                }
                                if (mounted) {
                                  ref.read(_loadingState.notifier).state =
                                      false;
                                }
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Already have an account?"),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.primary,
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () async {
                                    widget.toggleView();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
