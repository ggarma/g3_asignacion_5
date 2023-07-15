import 'package:flutter/material.dart';

TextField AndroidTextField(
  String hint,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
    ),
  );
}

TextField AndroidSecuredField(String hint, TextEditingController controller,
    Function onTap, bool isObscured) {
  return TextField(
    controller: controller,
    obscureText: isObscured,
    decoration: InputDecoration(
      hintText: hint,
      suffixIcon: Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          child:
              isObscured ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          onTap: () {
            onTap();
          },
        ),
      ),
    ),
  );
}

ElevatedButton AndroidButton(Widget widget, Function doSomething) {
  return ElevatedButton(
    onPressed: () {
      doSomething();
    },
    child: widget,
  );
}
