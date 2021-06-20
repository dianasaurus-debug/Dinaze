import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerScreen extends StatefulWidget {
  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  final _pdfViewerKey = GlobalKey();
  final _pdfTitle = Get.arguments[0] as String;
  final _pdfUrl = Get.arguments[1] as String;
  final _pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pdfTitle),
          centerTitle: true,
          leading: CloseButton(),
        ),
        body: SfPdfViewer.network(
          _pdfUrl,
          key: _pdfViewerKey,
          controller: _pdfViewerController,
        ),
      ),
    );
  }
}
