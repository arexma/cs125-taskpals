import 'package:flutter/material.dart';

// An editable text field constrained by a box

// TODO:
// Fix cursor size depending on box size

// Can make it so that if the user clicks outside the box midway through editing text, don't save current changes
Map<Alignment, TextAlign> alignments = {
  Alignment.centerLeft: TextAlign.left,
  Alignment.centerRight: TextAlign.right,
  Alignment.center: TextAlign.center,
};

class EditableTextField extends StatefulWidget {
  // Widget variables for customization
  final String? initialText;
  final double? boxWidth;
  final double? boxHeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final double? padding;
  final Color? textColor;
  final Shadow? textShadow;
  final double? textSize;
  final AlignmentGeometry? textAlignment;
  final Function(dynamic)? callback;

  const EditableTextField({
    super.key,
    this.initialText,
    this.boxWidth,
    this.boxHeight,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.textColor,
    this.textShadow,
    this.textSize,
    this.textAlignment,
    this.callback,
  });

  @override
  State<EditableTextField> createState() => EditableTextFieldState();
}

class EditableTextFieldState extends State<EditableTextField> {
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
    widget.callback?.call(newText);
  }

  void resetText() {
    _controller.text = '';
    setState(() {});
  }

  String getCurrentText() {
    return _controller.text;
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.borderColor ?? Colors.black,
        width: widget.borderWidth ?? 2,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.boxWidth ?? 250,
      height: widget.boxHeight ?? 40,
      child: GestureDetector(
        onTap: _toggleEdit,
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: false,
          decoration: InputDecoration(
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            filled: true,
            fillColor: widget.backgroundColor ?? Colors.transparent,
            contentPadding: EdgeInsets.all(widget.padding ?? 5),
          ),
          onTapOutside: (PointerDownEvent event) {
            _handleSave(_controller.text);
          },
          onSubmitted: (String newText) {
            _handleSave(newText);
          },
          textAlign: alignments[widget.textAlignment ?? Alignment.centerLeft] ??
              TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: widget.textColor ?? Colors.black,
            fontSize: widget.textSize ?? 14.0,
            shadows: [
              widget.textShadow ?? const Shadow(),
            ],
          ),
        ),
      ),
    );
  }
}
