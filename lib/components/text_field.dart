import 'package:flutter/material.dart';
import '../../theme/colors.dart' as futa_map_colors;

class InputField extends StatelessWidget {
  const InputField(
    this.width, {
    this.controller,
    this.keyboardType,
    this.hintText,
    this.backgroundColor,
    this.readOnly = false,
    this.enabled,
    this.showPassword = false,
    this.isPassword = false,
    this.error = false,
    this.errorText = "",
    this.onChanged,
    this.onPressed,
    super.key,
  });

  final TextEditingController? controller;
  final double width;
  final TextInputType? keyboardType;
  final String? hintText;
  final Color? backgroundColor;
  final bool readOnly;
  final bool? enabled;
  final bool isPassword;
  final bool showPassword;
  final bool error;
  final String errorText;
  final void Function(String)? onChanged;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            enabled: enabled,
            onChanged: onChanged,
            cursorColor: const Color(0xFF3734A9),
            readOnly: readOnly,
            obscureText: !showPassword && isPassword,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              fillColor: backgroundColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: error
                      ? futa_map_colors.Colors.error
                      : const Color(0xFFF9FAFB),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16)),
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
              suffixIcon: isPassword
                  ? IconButton(
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
                    )
                  : null,
            ),
          ),
          if (error)
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                errorText,
                style: const TextStyle(
                  color: futa_map_colors.Colors.error,
                  fontSize: 14,
                ),
              ),
            )
        ],
      ),
    );
  }
}
