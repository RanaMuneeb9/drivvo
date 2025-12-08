import 'package:drivvo/custom-widget/common/label_text.dart';
import 'package:drivvo/custom-widget/text-input-field/form_label_text.dart';
import 'package:drivvo/utils/utils.dart';
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final bool isRequired;
  final bool isNext;
  final bool obscureText;
  final bool readOnly;
  final String labelText;
  final String hintText;
  final TextInputAction inputAction;
  final TextInputType type;
  final Icon? prefixIcon;
  final Icon? sufixIcon;
  final Function(String? value) onSaved;
  final Function(String? value) onValidate;
  final Function(String? value)? onChange;
  final Function()? onTap;
  final String? initialValue;
  final int? maxLength;
  final int? maxLines;
  final bool isUrdu;

  const TextInputField({
    super.key,
    required this.isRequired,
    required this.isNext,
    required this.obscureText,
    required this.readOnly,
    required this.labelText,
    required this.hintText,
    required this.inputAction,
    required this.type,
    this.prefixIcon,
    this.sufixIcon,
    required this.onSaved,
    required this.onValidate,
    this.onChange,
    this.onTap,
    this.initialValue,
    this.maxLength,
    this.maxLines,
    required this.isUrdu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isRequired
            ? FormLabelText(title: labelText, isUrdu: isUrdu)
            : LabelText(title: labelText, isUrdu: isUrdu),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readOnly,
          maxLines: maxLines,
          style: Utils.getTextStyle(
            baseSize: 14,
            isBold: false,
            color: Colors.black,
            isUrdu: isUrdu,
          ),

          maxLength: maxLength,
          initialValue: initialValue,
          obscureText: obscureText,
          keyboardType: type,
          textInputAction: inputAction,
          decoration: InputDecoration(
            filled: true,
            errorStyle: Utils.getTextStyle(
              baseSize: 14,
              isBold: false,
              color: Colors.red,
              isUrdu: isUrdu,
            ),
            hintText: hintText,
            contentPadding: prefixIcon != null
                ? const EdgeInsets.symmetric(vertical: 16)
                : const EdgeInsets.all(16),
            prefixIcon: prefixIcon,
            suffixIcon: sufixIcon,
          ),
          onTap: onTap != null ? () => onTap!() : null,
          onSaved: (value) => onSaved(value),
          validator: (value) => onValidate(value),
        ),
      ],
    );
  }
}
