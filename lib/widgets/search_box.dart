import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String value) onChanged;

  const SearchBox({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
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
        child: TextField(
          onTapOutside: (value) {
            _onFocusChanged(false);
            debugPrint("Outside");
          },
          onChanged: (value) {
            widget.onChanged(value);
          },
          onTap: () {
            _onFocusChanged(true);
          },
          onEditingComplete: () {
            _onFocusChanged(false);
          },
          decoration: const InputDecoration(
            hintText: "Search for any newsletter",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
