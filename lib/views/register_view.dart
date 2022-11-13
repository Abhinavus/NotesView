

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';


import '../utilities/dialogs/error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
   late final TextEditingController _email;
  late final TextEditingController _password;
  
  get e => null;
 
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   _email.dispose();
   _password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
return Scaffold(
  
  body:   Padding(
    padding: const EdgeInsets.only(top: 200),
    child: Column(
              children: [
                Text('Hello !',
                style: TextStyle(
                fontWeight: FontWeight.bold,
                  fontSize: 50,
            ),),
             Padding(
              padding: const EdgeInsets.only(top:10),
              child: Text("Welcome to the APP",
                  style: TextStyle(
                    fontSize: 20,
              ),),
            ),SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                     decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                           border: InputBorder.none,
                          hintText: 'Enter your email here'
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                     decoration: BoxDecoration(color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextField(
                        controller:_password ,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your password here '
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  width: 340, height: 70,
            decoration: BoxDecoration(color: Color.fromARGB(255, 44, 69, 151),
            borderRadius: BorderRadius.circular(12)
            ),
                  child: TextButton(onPressed: () async {
                    final email=_email.text;
                    final password=_password.text;
                   try {

                  await AuthService.firebase().createUser(email: email, password: password);
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verifyEmailRoute);
              

                   } on WeakPasswordAuthExceptions{
                         await showErrorDialog(context,'Weak password',);
                   } on EmailAlreadyInUseAuthExceptions{
                    await  showErrorDialog(context,'Email already in use',);
                   } on InvalidEmailAuthExceptions{
                    await  showErrorDialog(context,'Invalid email',);
                   } on GenericAuthExceptions {
                      await showErrorDialog(context, 'Failed to register');
                   }
                   
                  },
                  child: const Text('Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
            ),
                  ),),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
                }, 
                child: const Text('Already registered? login here'))
              ],
            ),
  ),
);
  }}