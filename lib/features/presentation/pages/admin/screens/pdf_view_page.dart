import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/constants/global_variables.dart';

class PdfViewPage extends StatefulWidget {
  static const String routeName = "pdf-page";
  final String? path;
  final String titlePage;

  const PdfViewPage({super.key, this.path, required this.titlePage});
  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> with WidgetsBindingObserver {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SfPdfViewer.file(File(widget.path!)),
    );
  }

  _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title:
          Text(widget.titlePage, style: const TextStyle(color: Colors.white)),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.share,
            color: Colors.white,
          ),
          onPressed: () {
            Share.shareXFiles([XFile(widget.path!)],
                text: '${widget.titlePage} Paylaş');
          },
        ),
      ],
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
