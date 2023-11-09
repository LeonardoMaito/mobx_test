
import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/controller/controller_contract.dart';
import 'package:prova_target_sistemas/utils/constants/url.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/validator.dart';

class LoginController implements ControllerContract {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final Uri _url = Uri.parse(url);

  GlobalKey<FormState> get formKey => _formKey;
  get passwordController => _passwordController;
  get usernameController => _usernameController;

  String? validateUser(String? user) => LoginValidator.validateLogin(user);

  String? validatePassword(String? password) => LoginValidator.validatePassword(password);

  bool submit() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Future<void> launchLink() async{
    if (!await canLaunchUrl(_url)) {
      debugPrint('Não foi possível lançar $_url');
      return;
    }
    await launchUrl(_url);
  }
}