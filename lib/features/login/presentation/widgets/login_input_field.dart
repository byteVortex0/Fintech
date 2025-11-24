import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? prefixIcon;

  const LoginInputField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.prefixIcon,
  });

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: const Color(0xFF9CA3AF),
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              )
            : null,
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () => setState(() => _obscureText = !_obscureText),
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xFF3B5998), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xFF3B5998), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: const Color(0xFF1A2B4A), width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }
}
