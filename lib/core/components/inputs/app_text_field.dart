import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'input_styles.dart';

/// Labelled text field. Set [isPassword] for an obscured field with a
/// show/hide toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.initialValue,
    this.controller,
    this.focusNode,
    this.isPassword = false,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
  });

  final String? label;
  final String? hintText;
  final String? helperText;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isPassword;
  final bool isRequired;
  final bool enabled;
  final bool readOnly;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    final styles = InputStyles.of(context);

    Widget? suffix = widget.suffixIcon;
    if (widget.isPassword) {
      suffix = IconButton(
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20,
          color: styles.hint,
        ),
        onPressed: () => setState(() => _obscureText = !_obscureText),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          InputLabel(widget.label!, isRequired: widget.isRequired),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          style: styles.textStyle,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          onTap: widget.onTap,
          decoration: styles.decoration(
            hintText: widget.hintText,
            helperText: widget.helperText,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 20, color: styles.hint),
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
