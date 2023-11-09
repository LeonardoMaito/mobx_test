
import 'package:flutter/material.dart';

Widget policyTextField(VoidCallback onTap) {
    return InkWell(
      onTap:onTap,
      child: Text(
        "Política de Privacidade",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
        ),
      ),
    );
}