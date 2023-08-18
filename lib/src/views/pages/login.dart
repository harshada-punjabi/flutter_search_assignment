import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // This list holds the data for the list view

    return ChangeNotifierProvider(
      create: (context) => LoginController(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<LoginController>(
                      builder: (BuildContext context, bloc, child) =>
                          TextFormField(
                        onChanged: (value) => bloc.setEmail(value),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                    ),
                    Consumer<LoginController>(
                      builder: (BuildContext context, bloc, child) =>
                          (bloc.userEmail.isNotEmpty)
                              ? Text(
                                  bloc.emailValidationMessage(bloc.userEmail),
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              : Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<LoginController>(
                      builder: (BuildContext context, bloc, child) =>
                          TextFormField(
                        onChanged: (value) => bloc.setPassword(value),
                        obscureText: true,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Consumer<LoginController>(
                      builder: (BuildContext context, bloc, child) =>
                          (bloc.userPassword.isNotEmpty)
                              ? Text(
                                  bloc.passwordValidationMessage,
                                  style: TextStyle(
                                      color: (bloc.userPassword == "123456" ||
                                              bloc.userPassword.length < 6)
                                          ? Colors.red
                                          : Colors.green),
                                )
                              : Container(),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Consumer<LoginController>(
                  builder: (BuildContext context, bloc, child) =>
                      ElevatedButton(
                    onPressed: bloc.isLoginButtonEnabled
                        ? () {
                            bloc.login(context);
                          }
                        : null,
                    child: const Text('Login'),
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
