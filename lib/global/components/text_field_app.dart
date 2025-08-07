import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isRequired;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;
  final Widget? suffix;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.isRequired = false,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.enabled = true,
    this.suffix,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final borderColor = widget.borderColor ??
        (isDark ? const Color(0xFF404040) : const Color(0xFFE0E0E0));

    final focusedBorderColor = const Color(0xFF2E8B8B);

    final textColor = isDark ? Colors.white : const Color(0xFF404040);

    final hintColor =
        isDark ? const Color(0xFFB0B0B0) : const Color(0xFF5A5A5A);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText! + (widget.isRequired ? ' *' : ''),
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _isObscured : false,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          inputFormatters: widget.inputFormatters,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: hintColor,
            ),

            // الأيقونات
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: hintColor,
                    size: 20,
                  )
                : null,

            suffixIcon: _buildSuffixIcon(),
            suffix: widget.suffix,

            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

            filled: false,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(color: borderColor, width: 2),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: BorderSide(color: focusedBorderColor, width: 2),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: const BorderSide(color: Color(0xFFE57373), width: 1),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide: const BorderSide(color: Color(0xFFE57373), width: 2),
            ),

            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
              borderSide:
                  BorderSide(color: borderColor.withOpacity(0.5), width: 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _isObscured ? Icons.visibility_off : Icons.visibility,
          color: const Color(0xFF5A5A5A),
          size: 20,
        ),
        onPressed: () {
          setState(() {
            _isObscured = !_isObscured;
          });
        },
      );
    } else if (widget.suffixIcon != null) {
      return Icon(
        widget.suffixIcon,
        color: const Color(0xFF5A5A5A),
        size: 20,
      );
    }
    return null;
  }
}
