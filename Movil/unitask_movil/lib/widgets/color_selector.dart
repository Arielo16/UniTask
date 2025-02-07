import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorSelector extends StatefulWidget {
  final Function(Color) onPrimaryColorChanged;
  final Function(Color) onSecondaryColorChanged;

  const ColorSelector({
    super.key,
    required this.onPrimaryColorChanged,
    required this.onSecondaryColorChanged,
  });

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color _primaryColor = Color(0xFF00664F);
  Color _secondaryColor = Color(0xFF4DC591);

  void _selectPrimaryColor() async {
    Color? selectedColor = await showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(initialColor: _primaryColor),
    );
    if (selectedColor != null) {
      setState(() {
        _primaryColor = selectedColor;
      });
      widget.onPrimaryColorChanged(_primaryColor);
    }
  }

  void _selectSecondaryColor() async {
    Color? selectedColor = await showDialog(
      context: context,
      builder: (context) => ColorPickerDialog(initialColor: _secondaryColor),
    );
    if (selectedColor != null) {
      setState(() {
        _secondaryColor = selectedColor;
      });
      widget.onSecondaryColorChanged(_secondaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Primary Color'),
          trailing: CircleAvatar(backgroundColor: _primaryColor),
          onTap: _selectPrimaryColor,
        ),
        ListTile(
          title: const Text('Secondary Color'),
          trailing: CircleAvatar(backgroundColor: _secondaryColor),
          onTap: _selectSecondaryColor,
        ),
      ],
    );
  }
}

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Color'),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: initialColor,
          onColorChanged: (color) {
            Navigator.of(context).pop(color);
          },
        ),
      ),
    );
  }
}
