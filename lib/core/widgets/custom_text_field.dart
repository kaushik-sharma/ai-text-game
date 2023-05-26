import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSuffixPress;

  const CustomTextField(
      {Key? key, required this.controller, required this.onSuffixPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: _buildInputBorder(),
        enabledBorder: _buildInputBorder(),
        errorBorder: _buildInputBorder(Colors.red),
        focusedBorder: _buildInputBorder(),
        disabledBorder: _buildInputBorder(Colors.grey),
        focusedErrorBorder: _buildInputBorder(Colors.red),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        suffixIcon: IconButton(
          onPressed: onSuffixPress,
          iconSize: 34,
          icon: Icon(Icons.chevron_right),
        ),
      ),
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      minLines: 1,
      maxLines: 4,
      textInputAction: TextInputAction.newline,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
    );
  }

  OutlineInputBorder _buildInputBorder([Color color = Colors.white]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(35),
      borderSide: BorderSide(
        color: color,
        width: 2.0,
      ),
    );
  }
}
