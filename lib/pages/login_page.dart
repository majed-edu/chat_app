import 'package:chat_app/constant.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: PrimaryColor,

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(height: 75),
                Image.asset('assets/images/scholar.png', height: 100),

                SizedBox(height: 75),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                CustomTextFormField(
                  hintText: 'Email',
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(

                  obscureText: true,
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 20),

                CustomButton(
                  text: 'Login',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(
                          context,
                          'ChatPage',
                          arguments: email,
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(
                            context,
                            'No user found for that email.',
                          );
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'The password is incorrect.');
                        } else if (e.code == 'invalid-credential') {
                          showSnackBar(
                            context,
                            'Email or password is incorrect.',
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                          context,
                          'An error occurred. Please try again.',
                        );
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t hava an account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'RegisterPage'),
                      child: Text(
                        'Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
