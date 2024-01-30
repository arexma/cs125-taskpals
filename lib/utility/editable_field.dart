import 'package:flutter/material.dart';

// An editable text field constrained by a box

// Can make it so that if the user clicks outside the box midway through editing text, don't save current changes
class EditableTextField extends StatefulWidget {
  // Widget variables for customization
  final String? initialText;
  final double? boxWidth;
  final double? boxHeight;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? edgeInsets;
  final AlignmentGeometry? textAlignment;

  const EditableTextField({
    Key? key,
    this.initialText,
    this.boxWidth,
    this.boxHeight,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.edgeInsets,
    this.textAlignment,
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
    _controller = TextEditingController(text: widget.initialText ?? '');
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
      _controller.text = newText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Can use MediaQuery to dynamically resize box based on screen size
      width: widget.boxWidth ?? 250,
      height: widget.boxHeight ?? 40,
      child: GestureDetector(
        onTap: _toggleEdit,
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.borderColor ?? Colors.black,
              width: widget.borderWidth ?? 2,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          padding: EdgeInsets.all(widget.edgeInsets ?? 5),
          child: Align(
            alignment: widget.textAlignment ?? Alignment.centerLeft,
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
                : Text(
                    _controller.text,
                  ),
          ),
        ),
      ),
    );
  }
}
