import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget suffix;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.suffix,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type your response',
        border: _buildInputBorder(Colors.white30),
        enabledBorder: _buildInputBorder(Colors.white30),
        disabledBorder: _buildInputBorder(Colors.white30),
        focusedBorder: _buildInputBorder(Colors.white),
        errorBorder: _buildInputBorder(Theme.of(context).colorScheme.error),
        focusedErrorBorder:
            _buildInputBorder(Theme.of(context).colorScheme.error),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        suffixIcon: suffix,
      ),
      keyboardType: TextInputType.number,
      maxLines: 1,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter(RegExp(r'[1-3]'),
            allow: true, replacementString: ''),
      ],
      textInputAction: TextInputAction.send,
      onFieldSubmitted: onFieldSubmitted,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  OutlineInputBorder _buildInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: color),
    );
  }
}
