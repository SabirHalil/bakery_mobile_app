import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../../../../core/constants/global_variables.dart';

class PdfViewPage extends StatefulWidget {
  static const String routeName = "pdf-page";
  final String fileName;
  final String titlePage;
  final Uint8List byteList;

  const PdfViewPage(
      {super.key,
      required this.titlePage,
      required this.byteList,
      required this.fileName});
  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: PdfPreview(
        build: (context) => widget.byteList,
        pdfFileName: '${widget.fileName}.pdf',
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title:
          Text(widget.titlePage, style: const TextStyle(color: Colors.white)),
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: GlobalVariables.secondaryColor,
      centerTitle: true,
    );
  }
}
