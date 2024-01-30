import 'package:flutter/material.dart';

class EditableTextField extends StatefulWidget {
  // Widget variables for customization
  final String initialText;

  const EditableTextField({
    Key? key,
    required this.initialText,
  }) : super(key: key);

  @override
  State<EditableTextField> createState() => _EditableTextField();
}

class _EditableTextField extends State<EditableTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
    _focusNode.unfocus();
  }

  void _handleSave(String newText) {
    _toggleEdit();
    setState(() {
      _controller = TextEditingController(text: newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Can use MediaQuery to dynamically resize box based on screen size
      width: 250,
      child: GestureDetector(
        onTap: _toggleEdit,
        child: IntrinsicHeight(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(5),
            child: _isEditing
                ? TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    onTapOutside: (PointerDownEvent event) {
                      _toggleEdit();
                    },
                    onSubmitted: (String newText) => _handleSave(newText),
                  )
                : Text(widget.initialText),
          ),
        ),
      ),
    );
  }
}
