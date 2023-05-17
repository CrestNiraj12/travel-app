import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:traveller/components/loader.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/states/auth/auth.provider.dart';

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'Email is required'),
  PatternValidator(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorText: 'Invalid Email')
]);

class SignInScreen extends ConsumerStatefulWidget {
  final Function toggleView;
  SignInScreen({required this.toggleView});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loadingState = StateProvider<bool>((ref) => false);
  final _hidePasswordState = StateProvider<bool>((ref) => true);

  void hidePassword(bool hide) {
    ref.read(_hidePasswordState.notifier).state = !hide;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_loadingState);
    final hide = ref.watch(_hidePasswordState);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  "images/logo.png",
                  color: Colors.blueAccent,
                  height: 80,
                  width: 80,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Traveller",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 50,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                            obscureText: hide,
                            controller: _passwordController,
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
                                onPressed: () => hidePassword(hide),
                              ),
                            ),
                            validator: passwordValidator,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black45,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
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

                              if (_formKey.currentState?.validate() ?? false) {
                                await ref.read(authProvider.notifier).loginUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                              }
                              if (mounted) {
                                ref.read(_loadingState.notifier).state = false;
                              }
                            },
                          ),
                          // SizedBox(
                          //   height: 30,
                          // ),
                          // Center(
                          //   child: SizedBox(
                          //     child: TextButton(
                          //       style: TextButton.styleFrom(
                          //         elevation: 5,
                          //         shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.all(
                          //             Radius.circular(30),
                          //           ),
                          //         ),
                          //         backgroundColor: Colors.black45,
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         children: <Widget>[
                          //           Image.asset(
                          //             "images/google.webp",
                          //             height: 35,
                          //             width: 50,
                          //           ),
                          //           Text(
                          //             "Google",
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontSize: 14,
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //       onPressed: () async {},
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Don\'t have account?"),
                              TextButton(
                                child: Text(
                                  "Register",
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
    );
  }
}
