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
  final double? edgeInsets;
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
    this.edgeInsets,
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
            color: widget.backgroundColor ?? Colors.transparent,
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
                ? Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        widget.textShadow == null
                            ? const BoxShadow(
                                color: Colors.transparent,
                              )
                            : BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(2.0, 2.0),
                                blurRadius: 4.0,
                              )
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode,
                      autofocus: true,
                      onTapOutside: (PointerDownEvent event) {
                        _handleSave(_controller.text);
                      },
                      onSubmitted: (String newText) {
                        _handleSave(newText);
                      },
                      textAlign: alignments[
                              widget.textAlignment ?? Alignment.centerLeft] ??
                          TextAlign.left,
                      style: TextStyle(
                        color: widget.textColor ?? Colors.black,
                      ),
                    ),
                  )
                : Text(
                    _controller.text,
                    style: TextStyle(
                      color: widget.textColor ?? Colors.black,
                      fontSize: widget.textSize ?? 14.0,
                      shadows: [
                        widget.textShadow ?? const Shadow(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
