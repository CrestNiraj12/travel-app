import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/services/auth_service.dart';
import 'package:traveller/traveller-main-page.dart';
import 'package:traveller/utils/colors.dart';

class ResetPasswordForm extends ConsumerStatefulWidget {
  ResetPasswordForm({
    Key? key,
    required this.email,
    required this.token,
  }) : super(key: key);
  final String email, token;
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends ConsumerState<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final _loadingProvider = StateProvider<bool>((ref) => false);

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  snackBar(String message, SnackbarType type) {
    globalScaffoldKey.currentState?.removeCurrentSnackBar();
    return globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: message,
        type: type,
      ),
    );
  }

  Future<Null> _handleSubmit() async {
    final validated = _formKey.currentState?.validate() ?? false;
    if (!validated) return;

    ref.read(_loadingProvider.notifier).state = true;
    try {
      final data = {
        "email": widget.email,
        "token": widget.token,
        "password": passController.text,
        "password_confirmation": confirmPassController.text
      };

      await ref.read(authServiceProvider).changePassword(data);
      snackBar('Password changed successfully!', SnackbarType.success);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Traveller(
            screen: Screens.profile,
          ),
        ),
      );
    } on DioError catch (e) {
      snackBar(
        e.response?.data['errors']['password'][0] ??
            e.response?.data['message'],
        SnackbarType.error,
      );
    } catch (e) {
      snackBar(
        e.toString(),
        SnackbarType.error,
      );
    } finally {
      ref.read(_loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_loadingProvider);

    TextStyle style = new TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    );
    TextStyle btnStyle = new TextStyle(
      color: Colors.white,
      fontSize: 12.0,
      letterSpacing: 0.5,
      fontFamily: 'Montserrat',
    );

    //Decoration for textfields
    InputDecoration inputFieldDecorate(labelText, IconData prefixIcon) {
      return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.blueAccent,
        ),
        focusColor: Colors.blueAccent,
        border: OutlineInputBorder(),
        labelStyle: style,
        labelText: labelText,
        errorMaxLines: 2,
      );
    }

    final Widget passField = TextFormField(
        controller: passController,
        obscureText: true,
        autocorrect: false,
        style: style,
        validator: (value) => value != null && value.trim().length < 8
            ? "Password must be at least 8 characters long"
            : null,
        decoration: inputFieldDecorate("Password", Icons.vpn_key));

    final Widget confirmPassField = TextFormField(
        controller: confirmPassController,
        obscureText: true,
        autocorrect: false,
        style: style,
        validator: (value) => value!.isEmpty
            ? "Please confirm your password!"
            : value != passController.text
                ? "Passwords do not match!"
                : null,
        decoration:
            inputFieldDecorate("Confirm Password", Icons.confirmation_num));

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 180,
                      child: Image.asset('images/logo.png'),
                    ),
                    Text(
                      "Please fill up the following fields to reset your password",
                      textAlign: TextAlign.left,
                      style: style.copyWith(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 30.0),
                    passField,
                    SizedBox(
                      height: 15.0,
                    ),
                    confirmPassField,
                    SizedBox(
                      height: 35.0,
                    ),
                    ElevatedButton(
                      onPressed: isLoading ? null : _handleSubmit,
                      child: isLoading
                          ? Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Change Password',
                              style: btnStyle,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
