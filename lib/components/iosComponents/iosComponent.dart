import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

CupertinoTextField IOSTextField(
  String hint,
  TextEditingController controller,
) {
  return CupertinoTextField(
    controller: controller,
    placeholder: hint,
    cursorColor: const Color.fromARGB(255,255,140,0),
  );
}

CupertinoTextField IOSSecuredField(String hint,
    TextEditingController controller, Function onTap, bool isObscured) {
  return CupertinoTextField(
    controller: controller,
    obscureText: isObscured,
    placeholder: hint,
    suffix: Padding(
      padding: EdgeInsets.all(5),
      child: InkWell(
        child: isObscured
            ? Icon(CupertinoIcons.eye)
            : Icon(CupertinoIcons.eye_slash),
        onTap: () {
          onTap();
        },
      ),
    ),
  );
}

CupertinoButton IOSButton(Widget widget, Function doSomething, Color color) {
  return CupertinoButton(
      color: color,
      padding: EdgeInsets.all(5),
      child: widget,
      onPressed: () {
        doSomething();
      });
}
