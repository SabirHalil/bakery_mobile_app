import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/constants/global_variables.dart';

class PdfViewPage extends StatefulWidget {
  static const String routeName = "pdf-page";
  final String? path;
  final String titlePage;
  final Uint8List byteList;

  const PdfViewPage(
      {super.key, this.path, required this.titlePage, required this.byteList});
  @override
  State<PdfViewPage> createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  late File? pdfFile;

  // @override
  // void initState()  {
  //   super.initState();
  //   print('Byte List in pdf viewer: ${widget.byteList}');
  //   setPdfFile(widget.byteList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SfPdfViewer.file(File(widget.path!)),
    );
  }

  setPdfFile(Uint8List byteData) async {
    pdfFile = await savePdfFile(byteData);
    setState(() {
      
    });
  }

  Future<File> savePdfFile(Uint8List byteData) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.notoSansRegular();

    final String textContent = utf8.decode(utf8.encode(byteData.toString()));

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text(textContent, style: pw.TextStyle(font: font)),
        );
      },
    ));

    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/example.pdf';
    final File file = File(path);
    // PDF dosyasını kaydetmek veya paylaşmak için
//final m =  await Printing.sharePdf(bytes: await pdf.save(), filename: 'created_document.pdf');
    final m = await file.writeAsBytes(await pdf.save());
    return m;
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
