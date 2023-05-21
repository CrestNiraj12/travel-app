import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/profile/code_verification.dart';
import 'package:traveller/services/auth_service.dart';
import 'package:traveller/utils/colors.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(); // gets email address value
  final _loadingProvider = StateProvider<bool>((ref) => false);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() async {
    final validated = _formKey.currentState?.validate() ?? false;
    if (!validated) return;

    ref.read(_loadingProvider.notifier).state = true;

    globalScaffoldKey.currentState?.removeCurrentSnackBar();
    try {
      final email = _emailController.text.trim();
      await ref.read(authServiceProvider).forgetPassword(email: email);
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: 'Password reset code successfully sent to your email!',
          type: SnackbarType.success,
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CodeVerification(email: email),
        ),
      );
    } on DioError catch (e) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: e.response?.data['errors']['email'][0] ??
              e.response?.data['message'],
          type: SnackbarType.error,
        ),
      );
    } catch (e) {
      globalScaffoldKey.currentState?.showSnackBar(
        showSnackBar(
          content: e.toString(),
          type: SnackbarType.error,
        ),
      );
    } finally {
      if (mounted) ref.read(_loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(_loadingProvider);

    TextStyle style = new TextStyle(
      fontSize: 14.0,
    );
    TextStyle btnStyle = new TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        letterSpacing: 0.5,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold);

    InputDecoration inputFieldDecorate(labelText, prefixIcon) {
      return InputDecoration(
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.blue,
          ),
          focusColor: Colors.blue,
          border: OutlineInputBorder(),
          labelStyle: style,
          labelText: labelText,
          errorMaxLines: 2);
    }

    final Widget emailField = TextFormField(
      controller: _emailController,
      obscureText: false,
      style: style,
      validator: (value) =>
          value!.trim().isEmpty ? "Please enter your email!" : null,
      decoration: inputFieldDecorate(
        "Email address",
        Icons.email,
      ),
    );

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 120,
                        height: 180,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                    Text(
                      "Forgot password?",
                      style: style.copyWith(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "A password reset code will be sent to your email",
                      style: style.copyWith(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    emailField,
                    SizedBox(
                      height: 35.0,
                    ),
                    Center(
                      child: ElevatedButton(
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
                                'Verify',
                                style: btnStyle,
                              ),
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
