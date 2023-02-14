import 'package:flutter/material.dart';
import 'package:zoned_express/utils/constants.dart';

class CustomInputField extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final String? Function(String? val) validator;
  final Function(String? val) onChange;
  final String? initialValue;
  final bool obscureText;

  const CustomInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.validator,
    required this.onChange,
    this.initialValue = "",
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();

  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(_controller);

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChanged(bool hasFocus) {
    if (hasFocus) {
      _controller.forward();
    } else {
      _controller.reverse();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: TextFormField(
          initialValue: widget.initialValue,
          obscureText: widget.obscureText,
          onTapOutside: (val) {
            _onFocusChanged(false);
          },
          onEditingComplete: () {
            _onFocusChanged(false);
          },
          onTap: () {
            _onFocusChanged(true);
          },
          style: const TextStyle(fontSize: 14),
          decoration: inputDecoration.copyWith(
            hintText: widget.hintText,
            icon: Icon(
              widget.icon,
              color: Colors.grey,
            ),
          ),
          validator: widget.validator,
          onChanged: widget.onChange,
        ),
      ),
    );
  }
}
