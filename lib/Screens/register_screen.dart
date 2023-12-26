import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  //const RegisterScreen({super.key});
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailValid = RegExp(
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$'); //email validation
  bool locked = true;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Register',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.person_add,
                        size: 60,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //name textfield
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name is required";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                      cursorColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //email textfield
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!emailValid.hasMatch(value)) {
                          return "Email is invalid";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                      cursorColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Phone textfield
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone is required";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter your Phone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                      ),
                      cursorColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //password textfield
                    TextFormField(
                      obscureText: locked,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 8) {
                          return "Password must be at least 8 characters";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(locked ? Icons.lock : Icons.lock_open),
                          onPressed: () {
                            setState(() {
                              locked = !locked;
                            });
                          },
                        ),
                      ),
                      cursorColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //password 2 textfield
                    TextFormField(
                      obscureText: locked,
                      controller: _password2Controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        } else if (value != _passwordController.text) {
                          return "Password doesn't match";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Confirm your Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(locked ? Icons.lock : Icons.lock_open),
                          onPressed: () {
                            setState(() {
                              locked = !locked;
                            });
                          },
                        ),
                      ),
                      cursorColor: Colors.amber,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: ()async {
                        if (_formKey.currentState!.validate()) {
                          print('Registered Successfully');
                          await userProvider.register(_emailController.text,_passwordController.text,_nameController.text,_phoneController.text);

                        } else {
                          print('Try again');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber,
                        ),
                        child: const Text(
                          'Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
