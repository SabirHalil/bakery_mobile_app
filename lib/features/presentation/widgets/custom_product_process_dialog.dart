import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomProductProcessDialog extends StatefulWidget {
  final bool status;
  final String title;
  final String? numberLabel;
  final TextEditingController? nameController;
  final TextEditingController? numberController;
  final Function(bool, String, double) onSave;
  const CustomProductProcessDialog(
      {super.key,
      required this.title,
       this.nameController,
      this.numberController,
      this.numberLabel,
      required this.onSave,
      required this.status});

  @override
  State<CustomProductProcessDialog> createState() =>
      _CustomProductProcessDialogState();
}

class _CustomProductProcessDialogState
    extends State<CustomProductProcessDialog> {
  bool status = true;
  @override
  void initState() {
    super.initState();
    status = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Switch(
              value: status,
              onChanged: (bool value) {
                setState(() {
                  status = value;
                });
              }),
          if (widget.nameController != null)
            TextField(
              controller: widget.nameController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
          if (widget.numberController != null || widget.numberLabel != null)
            TextField(
              controller: widget.numberController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: InputDecoration(labelText: widget.numberLabel??'Fiyat'),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Vazgeç'),
        ), 
        TextButton(
          onPressed: () {
            if (widget.numberController != null) {
              double number = double.tryParse(widget.numberController!.text) ?? 0.0;
              String text = widget.nameController != null? widget.nameController!.text:'';
              if (number > 0 ) {
                widget.onSave(status, text, number);
                Navigator.of(context).pop();
                return;
              }
            }
            if (widget.nameController!.text.isNotEmpty) {
              widget.onSave(status, widget.nameController!.text, 0);
              Navigator.of(context).pop();
              return;
            }
            showToastMessage('Boşluklar doldurulmalı!');
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
