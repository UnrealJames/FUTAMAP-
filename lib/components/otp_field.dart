import 'package:flutter/material.dart';

class OTPField extends StatelessWidget {
  final double width;
  final String? hintText;
  final bool readOnly;
  final int length;
  final void Function(String code)? onFilled;

  const OTPField(
    this.width,
    this.length, {
    this.readOnly = false,
    this.onFilled,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
