import 'package:flutter/material.dart';
import '../../theme/colors.dart' as futa_map_colors;

Widget textField(
    {required double width,
    TextInputType? keyboardType,
    String? hintText,
    Color? backgroundColor,
    bool readOnly = false,
    bool enabled = true,
    void Function(String)? onChanged,
    void Function()? onPressed}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      enabled: enabled,
      onChanged: onChanged,
      cursorColor: const Color(0xFF3734A9),
      readOnly: readOnly,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: backgroundColor,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF9FAFB),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: futa_map_colors.Colors.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
      ),
    ),
  );
}

Widget passwordTextField(
    {required double width,
    String? hintText,
    Color? backgroundColor,
    required bool showPassword,
    void Function(String)? onChanged,
    void Function()? onPressed}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      onChanged: onChanged,
      cursorColor: const Color(0xFF3734A9),
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: !showPassword,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        fillColor: backgroundColor,
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF9FAFB),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: futa_map_colors.Colors.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        suffixIcon: IconButton(
          icon: showPassword
              ? const Icon(
                  Icons.visibility_outlined,
                  size: 24,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.visibility_off_outlined,
                  size: 24,
                  color: Colors.black,
                ),
          tooltip: 'Hide/Show password',
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

Widget dropdownTextField(
    {required double width,
    TextInputType? keyboardType,
    String? hintText,
    required bool expanded,
    bool enabled = true,
    required Function()? onPressed,
    void Function(String)? onChanged}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      enabled: enabled,
      readOnly: true,
      enableSuggestions: false,
      autocorrect: false,
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      onTap: onPressed,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        fillColor: const Color(0xFFF9FAFB),
        filled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFF9FAFB),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Color(0xFF3734A9),
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        hintText: hintText,
        suffixIcon: IconButton(
          icon: expanded
              ? const Icon(
                  Icons.arrow_drop_up,
                  size: 24,
                  color: Colors.black,
                )
              : const Icon(
                  Icons.arrow_drop_down,
                  size: 24,
                  color: Colors.black,
                ),
          tooltip: 'Hide/Show password',
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

Widget otpTextField({
  required double width,
  String? hintText,
  bool readOnly = false,
  required int length,
  required BuildContext context,
  void Function(String code)? onFilled,
}) {
  final focusNodes = List.generate(length, (index) => FocusNode());
  var code = StringBuffer();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      for (int i = 0; i < length; i++)
        SizedBox(
          width: 60,
          child: TextFormField(
            maxLength: 1,
            onChanged: ((value) {
              if (value.isNotEmpty && i < length - 1) {
                FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                code.write(value);
              }
              if (value.isEmpty && i > 0) {
                FocusScope.of(context).requestFocus(focusNodes[i - 1]);
                code.clear();
              }
              if (value.isNotEmpty && i == length - 1) {
                code.write(value);
                onFilled!(code.toString());
              }
            }),
            focusNode: focusNodes[i],
            autofocus: i == 0 ? true : false,
            enableSuggestions: false,
            autocorrect: false,
            cursorColor: const Color(0xFF3734A9),
            textAlign: TextAlign.center,
            readOnly: readOnly,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              fillColor: const Color(0xFFF9FAFB),
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFF9FAFB),
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Color(0xFF3734A9),
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              hintText: hintText,
            ),
          ),
        ),
    ],
  );
}
