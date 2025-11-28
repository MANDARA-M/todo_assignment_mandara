import 'package:flutter/material.dart';

typedef OnColorChanged = void Function(Color color);

class ColorPalette extends StatefulWidget {
  const ColorPalette({
    required this.colors,
    required this.selectedColor,
    required this.onColorChanged,
    super.key,
  });

  final List<Color> colors;
  final Color selectedColor;
  final OnColorChanged onColorChanged;

  @override
  _ColorPaletteState createState() => _ColorPaletteState();
}

class _ColorPaletteState extends State<ColorPalette> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
              color: widget.selectedColor,
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Center(
              child: Icon(
                Icons.colorize,
                color: Colors.white,
              ),
            ),
          ),
          ...widget.colors
              .map((color) => _ColorPicker(
                    color,
                    onColorChanged: widget.onColorChanged,
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker(
    this.color, {
    required this.onColorChanged,
  });

  final Color color;
  final OnColorChanged onColorChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onColorChanged(color),
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
