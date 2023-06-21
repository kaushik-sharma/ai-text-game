import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Widget suffix;
  final void Function(String) onFieldSubmitted;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.suffix,
      required this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Type your response',
        border: _buildInputBorder(Colors.white30),
        enabledBorder: _buildInputBorder(Colors.white30),
        errorBorder: _buildInputBorder(Colors.red),
        focusedBorder: _buildInputBorder(Colors.white),
        disabledBorder: _buildInputBorder(Colors.white30),
        focusedErrorBorder: _buildInputBorder(Colors.red),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 15,
        ),
        suffixIcon: suffix,
      ),
      keyboardType: TextInputType.number,
      // textCapitalization: TextCapitalization.sentences,
      // minLines: 1,
      // maxLines: 4,
      // textInputAction: TextInputAction.newline,
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
      borderSide: BorderSide(
        color: color,
        width: 1.0,
      ),
    );
  }
}
