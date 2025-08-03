import 'package:chat_box/services.dart/auth/auth_service.dart';
import 'package:chat_box/components/my_button.dart';
import 'package:chat_box/components/my_textField.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
 const RegisterPage({super.key, required this.onTap});

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emController = TextEditingController();

  final TextEditingController _pwController = TextEditingController();

  final TextEditingController _confirmPwController = TextEditingController();

  void register(BuildContext context) async {
    final _auth = AuthService();
    try {
  final userCredential = await _auth.signUpWithEmailPassword(
    _emController.text,
    _pwController.text,
  );

  if (userCredential.user != null) {
    print("✅ Registered user: ${userCredential.user!.email}");
    // Optional: Show a success message
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Registration Successful"),
      ),
    );
  }

} catch (e) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Registration Error"),
      content: Text(e.toString()),
    ),
  );
}


    // if (_pwController.text != _confirmPwController.text) {
      
    //   showDialog(
    //     context: context,
    //     builder: (context) => const AlertDialog(
    //       title: Text("Passwords do not match"),
    //     ),
    //   );
    //   return;
    // }

    // try {
    //   await _auth.signUpWithEmailPassword(
    //     _emController.text,
    //     _pwController.text,
    //   );
    // } catch (e) {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       title: Text("Registration Error"),
    //       content: Text(e.toString()),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView( 
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 50),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 30),
              MyTextfield(
                hintText: "Email",
                obscureText: false,
                controller: _emController,
              ),
              const SizedBox(height: 15),
              MyTextfield(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 15),
              MyTextfield(
                hintText: "Confirm Password", 
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 50),
              MyButton(
                text: "Register",
                onTap: () => register(context),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
