import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guruh2/core/theme/app_colors.dart';
import 'package:guruh2/core/theme/app_text_styles.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool isPhone;
  final bool isNumber;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final bool? autofocus;

  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.isPhone = false,
    this.isNumber = false,
    this.textStyle,
    this.hintStyle,
    this.contentPadding,
    this.autofocus,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _isObscured = true;

  late final MaskTextInputFormatter _phoneFormatter;

  @override
  void initState() {
    super.initState();
    _phoneFormatter = MaskTextInputFormatter(
      mask: '(##) ### ## ##',
      filter: {"#": RegExp(r'\d')},
      type: MaskAutoCompletionType.lazy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapUpOutside: (value) => FocusScope.of(context).unfocus(),
      onChanged: widget.onChanged,
      controller: widget.controller,
      enabled: widget.enabled,
      autofocus: widget.autofocus ?? false,
      keyboardType: widget.keyboardType ??
          (widget.isPhone ? TextInputType.phone : TextInputType.text),
      obscureText: widget.obscureText ? _isObscured : false,
      maxLines: widget.maxLines,
      validator: widget.validator,
      cursorColor: AppColors.textPrimary,
      cursorErrorColor: AppColors.error,
      style: widget.textStyle ??
          AppTextStyles.h3.copyWith(fontWeight: FontWeight.w700),
      inputFormatters: widget.isPhone
          ? <TextInputFormatter>[_phoneFormatter]
          : widget.isNumber
              ? <TextInputFormatter>[_ThousandsSeparatorInputFormatter()]
              : null,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        isDense: true,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            AppTextStyles.h3.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.darkText,
            ),
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.darkText),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.darkText),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.textPrimary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(44),
          borderSide: const BorderSide(color: AppColors.darkText),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ??
            (widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 15,
                      color: const Color(0xFFA3A3A3),
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null),
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}

class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final RegExp _digitOnlyRegex = RegExp(r'\D');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(_digitOnlyRegex, '');
    String formatted = _formatWithSpaces(digitsOnly);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  String _formatWithSpaces(String input) {
    if (input.isEmpty) return '';
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      int reversedIndex = input.length - i;
      buffer.write(input[i]);
      if (reversedIndex > 1 && reversedIndex % 3 == 1) {
        buffer.write(' ');
      }
    }
    return buffer.toString().trim();
  }
}
