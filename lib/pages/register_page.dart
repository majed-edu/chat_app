import 'package:chat_app/constant.dart';
import 'package:chat_app/helpers/show_snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                      'Register',
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
                  hintText: 'Password',
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(height: 20),

                CustomButton(
                  text: 'Register',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registorUser();
                        Navigator.pushNamed(context, 'ChatPage');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(
                            context,
                            'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(
                            context,
                            'The account already exists for that email.',
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
                      'already have account?  ',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registorUser() async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
