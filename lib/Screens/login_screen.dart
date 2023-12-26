import 'package:flutter/material.dart';
import 'package:intro_to_flutter/Components/button.dart';
import 'package:intro_to_flutter/Provider/user_provider.dart';
import 'package:intro_to_flutter/Screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool locked = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  } else if (!value.contains('@')) {
                    return "Email is invalid";
                  }
                  return null;
                },
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  hintText: 'Enter an Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: locked,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password is required";
                  } else if (value.length < 5) {
                    return "Password must be at least 5 char..";
                  }
                  return null;
                },
                cursorColor: Colors.amber,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(locked ? Icons.lock : Icons.lock_open),
                    onPressed: () {
                      setState(() {
                        locked = !locked;
                      });
                    },
                  ),
                  hintText: 'Enter a Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.amber),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    final res = await userProvider.signIn(
                    _emailController.text,
                    _passwordController.text,
                    );

                    if (!res) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(userProvider.message),
                        ),
                      );
                    }
                    if(mounted)
                    setState(() {
                      loading = false;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  child: loading
                      ? const Center(child: CircularProgressIndicator())
                      : const Text(
                          'Login',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: ()async {
                    await userProvider.signInWithGoogle();

                },
                child: const Button(
                  text: 'Sign in with google',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Register Now',
                      style: TextStyle(
                        color: Colors.amber,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
  
}
