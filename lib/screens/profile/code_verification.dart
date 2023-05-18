import 'dart:async';

import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:traveller/components/snackbar.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/profile/reset_password.dart';
import 'package:traveller/services/auth_service.dart';

class CodeVerification extends ConsumerStatefulWidget {
  CodeVerification({Key? key, required this.email}) : super(key: key);
  final String email;

  @override
  _CodeVerificationState createState() => _CodeVerificationState();
}

class _CodeVerificationState extends ConsumerState<CodeVerification> {
  TextEditingController _codeController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final _errorProvider = StateProvider<bool>((ref) => false);
  final _loadingProvider = StateProvider<bool>((ref) => false);
  final _resendLoadingProvider = StateProvider<bool>((ref) => false);
  final _codeProvider = StateProvider<String>((ref) => '');
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    errorController.close();
    _codeController.dispose();
    super.dispose();
  }

  snackBar(String message, SnackbarType type) {
    globalScaffoldKey.currentState?.removeCurrentSnackBar();
    globalScaffoldKey.currentState?.showSnackBar(
      showSnackBar(
        content: message,
        type: type,
      ),
    );
  }

  void handleSubmit(_) async {
    ref.read(_errorProvider.notifier).state = false;
    final validated = formKey.currentState?.validate() ?? false;
    if (!validated) return;

    ref.read(_loadingProvider.notifier).state = true;

    final code = ref.read(_codeProvider.notifier).state;

    try {
      if (code.length != 6) {
        errorController.add(ErrorAnimationType.shake);
        ref.read(_errorProvider.notifier).state = true;
      } else {
        await ref.read(authServiceProvider).verifyEmail(
              email: widget.email,
              code: code,
            );
        snackBar(
          "Email verified!",
          SnackbarType.success,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResetPasswordForm(
              email: widget.email,
              token: code,
            ),
          ),
        );
      }
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
      if (mounted) ref.read(_loadingProvider.notifier).state = false;
    }
  }

  void _resendCode() async {
    globalScaffoldKey.currentState?.removeCurrentSnackBar();
    ref.read(_resendLoadingProvider.notifier).state = true;

    try {
      await ref.read(authServiceProvider).forgetPassword(email: widget.email);
      globalScaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('Password reset code sent to your email successfully!'),
        backgroundColor: Colors.green,
      ));
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
      if (mounted) ref.read(_resendLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(_codeProvider);
    final hasError = ref.watch(_errorProvider);
    final isLoading = ref.watch(_loadingProvider);
    final isResendLoading = ref.watch(_resendLoadingProvider);

    return Scaffold(
      body: Center(
          child: Container(
        child: Padding(
            padding: EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 120,
                  height: 180,
                  child: Image.asset('images/logo.png'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Email verification',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 20),
                  child: RichText(
                    text: TextSpan(
                        text: "Enter the code sent to ",
                        children: [
                          TextSpan(
                              text: "${widget.email}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15)),
                        ],
                        style:
                            TextStyle(color: Colors.grey[700], fontSize: 15)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        animationType: AnimationType.scale,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeColor:
                              hasError ? Colors.red : Colors.blueAccent,
                          activeFillColor: Colors.white,
                          selectedColor:
                              hasError ? Colors.redAccent : Colors.blueAccent,
                          inactiveColor:
                              hasError ? Colors.redAccent : Colors.grey,
                          inactiveFillColor: Colors.grey.withAlpha(50),
                          selectedFillColor: Colors.white,
                        ),
                        cursorColor: Colors.blueAccent,
                        animationDuration: Duration(milliseconds: 200),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: _codeController,
                        autoDisposeControllers: false,
                        keyboardType: TextInputType.number,
                        onCompleted: (isLoading || isResendLoading)
                            ? null
                            : handleSubmit,
                        beforeTextPaste: (text) {
                          return true;
                        },
                        onChanged: (String value) {
                          if (!isLoading || !isResendLoading)
                            ref.read(_codeProvider.notifier).state = value;
                        },
                      )),
                ),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Please enter valid code",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Didn't receive the code? ",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    ),
                    isResendLoading
                        ? SizedBox(
                            height: 10,
                            width: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : TextButton(
                            onPressed: _resendCode,
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          )
                  ],
                ),
              ],
            )),
      )),
    );
  }
}
