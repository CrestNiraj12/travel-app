import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:traveller/components/loader.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/utils/firebase_service.dart';

class Registration extends StatefulWidget {
  final Function toggleView;
  Registration({required this.toggleView});
  @override
  _RegistrationState createState() => _RegistrationState();
}

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'Password is required'),
  MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])',
      errorText: 'Passwords must have at least one special character')
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

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  "images/story.png",
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
                            obscureText: _hidePassword,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: _hidePassword
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _hidePassword = !_hidePassword;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _hidePassword = !_hidePassword;
                                          });
                                        },
                                      )),
                            validator: passwordValidator,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _hidePassword,
                            decoration: textInputDecoration.copyWith(
                                hintText: "Confirm Password",
                                prefixIcon: Icon(
                                  Icons.lock,
                                ),
                                suffixIcon: _hidePassword
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.visibility,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _hidePassword = !_hidePassword;
                                          });
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _hidePassword = !_hidePassword;
                                          });
                                        },
                                      )),
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
                            child: _loading
                                ? Loader()
                                : Icon(
                                    Icons.arrow_forward,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                            onPressed: () async {
                              setState(() {
                                _loading = true;
                              });
                              if (_formKey.currentState?.validate() ?? false) {
                                await createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name: _nameController.text,
                                );
                              }
                              if (mounted) {
                                setState(() {
                                  _loading = false;
                                });
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
    );
  }
}
