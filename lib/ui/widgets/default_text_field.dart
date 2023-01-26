import 'package:flutter/material.dart';

class DefaultTextField extends StatefulWidget {
  final bool obscureText;
  final Color backgroundColor;
  final String labelText;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final void Function(String) onFieldSubmitted;
  final TextStyle style;
  final String initValue;
  const DefaultTextField(
      {Key? key,
      this.obscureText = false,
      this.backgroundColor = Colors.white,
      required this.labelText,
      required this.focusNode,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.validator,
      this.onSaved,
      required this.style,
      required this.onFieldSubmitted,
      this.initValue = ''})
      : super(key: key);

  @override
  DefaultTextFieldState createState() => DefaultTextFieldState();
}

class DefaultTextFieldState extends State<DefaultTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: widget.labelText,
        fillColor: widget.backgroundColor,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        errorStyle: const TextStyle(fontSize: 11.0),
      ),
      obscureText: widget.obscureText,
      textAlign: TextAlign.start,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      onSaved: widget.onSaved,
      focusNode: widget.focusNode,
      style: widget.style,
      onFieldSubmitted: widget.onFieldSubmitted,
      initialValue: widget.initValue,
    );
  }
}
