import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../utils/theme/theme_provider.dart';

class PDFViewer extends StatelessWidget {
  final String? pdfLink;

  const PDFViewer({Key? key, required this.pdfLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: getTheme(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
        ),
        body: PDFView(
          filePath: pdfLink,
          enableSwipe: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (pages) {
            debugPrint("Rendered $pages pages.");
          },
          onError: (error) {
            debugPrint(error.toString());
          },
          onPageError: (page, error) {
            debugPrint('$page: ${error.toString()}');
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
