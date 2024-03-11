import 'package:bakery_app/core/utils/toast_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomProductProcessDialog extends StatefulWidget {
  final status;
  final String title;
  final String numberLabel;
  final TextEditingController nameController;
  final TextEditingController numberController;
  final Function(bool, String, double) onSave;
  const CustomProductProcessDialog(
      {super.key,
      required this.title,
      required this.nameController,
      required this.numberController,
      required this.numberLabel,
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
          TextField(
            controller: widget.nameController,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(labelText: 'İsim'),
          ),
          TextField(
            controller: widget.numberController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            decoration: InputDecoration(labelText: widget.numberLabel),
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
            double number =
                double.tryParse(widget.numberController.text) ?? 0.0;
            if (number > 0 && widget.nameController.text.isNotEmpty) {
              widget.onSave(status, widget.nameController.text, number);
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
