import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/controller/login_controller.dart';
import 'package:prova_target_sistemas/utils/constants/policy_widget.dart';
import 'package:prova_target_sistemas/views/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = LoginController();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xFF2e968f), Color(0xFF1e4e62)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: loginController.formKey,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 8, left: 10),
                        child: Text(
                          'Usuário',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      getUsernameField(loginController),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 4, top: 20, left: 10),
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      getPasswordField(loginController),
                      Align(
                        alignment: Alignment.center,
                        child: getLoginButton(loginController,context),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: policyTextField(() async {
                  await loginController.launchLink();
                })
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getUsernameField(LoginController loginController) {
    return TextFormField(
      controller: loginController.usernameController,
      textAlign: TextAlign.start,
      validator: (value) {
        return loginController.validateUser(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.person_rounded, color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
              color:
                  Colors.transparent), // Border color set to black when focused
        ),
      ),
      style: const TextStyle(color: Colors.black),
    );
  }

  Widget getPasswordField(LoginController loginController) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextFormField(
        obscureText: true,
        controller: loginController.passwordController,
        textAlign: TextAlign.start,
        validator: (value) {
          return loginController.validatePassword(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(Icons.lock, color: Colors.black),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(
                color: Colors
                    .transparent), // Border color set to black when focused
          ),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget getLoginButton(LoginController loginController, BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if(loginController.submit()){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 40),
          backgroundColor: const Color(0xFF44bd6e),
          shape: const StadiumBorder(),
        ),
        child: const Text("Entrar"));
  }
}
