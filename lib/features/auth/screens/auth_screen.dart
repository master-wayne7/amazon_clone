import 'package:amazno_clone/common/widgets/custom_button.dart';
import 'package:amazno_clone/common/widgets/custom_textfield.dart';
import 'package:amazno_clone/constants/global_variables.dart';
import 'package:amazno_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      context: context,
    );
  }

  void signInUser() {
    authService.signInUser(
      email: _emailController.text,
      password: _passwordController.text,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  tileColor: _auth == Auth.signUp
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Create account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    value: Auth.signUp,
                    groupValue: _auth,
                    activeColor: GlobalVariables.secondaryColor,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signUp)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textEditingController: _nameController,
                            hintText: "name",
                            type: TextInputType.name,
                            autoFillHints: const [
                              AutofillHints.name,
                              AutofillHints.nameSuffix,
                              AutofillHints.middleName,
                              AutofillHints.namePrefix,
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textEditingController: _emailController,
                            hintText: "Email",
                            autoFillHints: const [AutofillHints.email],
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textEditingController: _passwordController,
                            hintText: "Password",
                            autoFillHints: const [
                              AutofillHints.newPassword,
                              AutofillHints.password,
                            ],
                            // type: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: "Sign Up",
                            onTap: () {
                              if (_signUpFormKey.currentState!.validate()) {
                                signUpUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ListTile(
                  tileColor: _auth == Auth.signIn
                      ? GlobalVariables.backgroundColor
                      : GlobalVariables.greyBackgroundCOlor,
                  title: const Text(
                    "Sign-In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: Radio(
                    value: Auth.signIn,
                    groupValue: _auth,
                    activeColor: GlobalVariables.secondaryColor,
                    onChanged: (Auth? val) {
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if (_auth == Auth.signIn)
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            textEditingController: _emailController,
                            hintText: "Email",
                            autoFillHints: const [AutofillHints.email],
                            type: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            textEditingController: _passwordController,
                            hintText: "Password",
                            autoFillHints: const [
                              AutofillHints.newPassword,
                              AutofillHints.password,
                            ],
                            // type: TextInputType.visiblePassword,
                            obscureText: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: "Sign In",
                            onTap: () {
                              if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
