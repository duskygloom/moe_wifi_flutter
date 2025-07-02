import 'package:flutter/material.dart';
import 'package:moe_wifi/core/widgets/text_input.dart';

class TextSuggestion extends StatefulWidget {
  const TextSuggestion({
    super.key,
    required this.controller,
    required this.suggestions,
    this.hintText,
    this.labelText,
    this.isPhone = false,
    this.isObscure = false,
    this.isFocused = false,
    this.isMandatory = false,
    this.onEnterPress,
    this.onTap,
    this.action,
    this.focusNode,
    this.onChanged,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final bool isPhone;
  final bool isFocused;
  final bool isObscure;
  final bool isMandatory;
  final TextInputAction? action;
  final FocusNode? focusNode;
  final Future<void> Function()? onEnterPress;
  final Future<void> Function()? onTap;
  final Future<void> Function(String value)? onChanged;
  final List<String> suggestions;

  @override
  State<TextSuggestion> createState() => _TextSuggestionState();
}

class _TextSuggestionState extends State<TextSuggestion> {
  final layerLink = LayerLink();
  OverlayEntry? entry;
  var suggestions = <String>[];

  void onFocus() {
    if (widget.focusNode!.hasFocus) {
      showOverlay(context, suggestions);
    } else {
      hideOverlay(context);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(onFocus);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode != null) {
      widget.focusNode!.removeListener(onFocus);
    }
    super.dispose();
  }

  void onChanged(String current) {
    suggestions = widget.suggestions.where((value) {
      if (value.isEmpty) return false;
      return value.toLowerCase().contains(current.toLowerCase());
    }).toList();
    if (widget.focusNode?.hasFocus == true) {
      showOverlay(context, suggestions);
    }
    setState(() {});
  }

  void showOverlay(BuildContext context, List<String> suggestions) {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    if (entry != null) hideOverlay(context);

    entry = OverlayEntry(builder: (context) {
      const xOffset = 0.0;
      return Positioned(
        width: size.width - 2 * xOffset,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(xOffset, 52),
          child: SuggestionsOverlay(
            suggestions: suggestions,
            onTap: (value) {
              widget.controller.text = value;
              hideOverlay(context);
            },
          ),
        ),
      );
    });

    overlay.insert(entry!);
  }

  void hideOverlay(BuildContext context) {
    if (entry != null) {
      entry!.remove();
      entry = null;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextInput(
        hintText: widget.hintText,
        labelText: widget.labelText,
        controller: widget.controller,
        isPhone: widget.isPhone,
        isObscure: widget.isObscure,
        isFocused: widget.isFocused,
        isMandatory: widget.isMandatory,
        action: widget.action,
        focusNode: widget.focusNode,
        onEnterPress: widget.onEnterPress,
        onChanged: (value) async {
          onChanged(value);
        },
      ),
    );
  }
}

class SuggestionsOverlay extends StatelessWidget {
  const SuggestionsOverlay({
    super.key,
    required this.suggestions,
    required this.onTap,
  });

  final List<String> suggestions;
  final void Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade400, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(suggestions.length, (index) {
            return ListTile(
              dense: true,
              title: Text(suggestions[index]),
              onTap: () {
                onTap(suggestions[index]);
              },
            );
          }),
        ),
      ),
    );
  }
}
