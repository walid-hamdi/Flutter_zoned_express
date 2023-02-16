// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

// import '../../utils/theme/theme_provider.dart';

// class PDFViewer extends StatelessWidget {
//   final String? pdfLink;

//   const PDFViewer({Key? key, required this.pdfLink}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: getTheme(context),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('PDF Viewer'),
//         ),
//         body: PDFView(
//           filePath: pdfLink,
//           enableSwipe: true,
//           autoSpacing: false,
//           fitEachPage: true,
//           pageFling: false,

//           onRender: (pages) {
//             debugPrint("Rendered $pages pages.");
//           },
//           onError: (error) {
//             debugPrint(error.toString());
//           },
//           onPageError: (page, error) {
//             debugPrint('$page: ${error.toString()}');
//           },
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Icon(
//             Icons.close,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/newsletter.dart';
import '../utils/theme/theme_provider.dart';

class NewsletterPdfViewer extends StatefulWidget {
  const NewsletterPdfViewer({
    Key? key,
    required this.newsletter,
  }) : super(key: key);

  final Newsletter newsletter;

  @override
  createState() => _NewsletterPdfViewerState();
}

class _NewsletterPdfViewerState extends State<NewsletterPdfViewer> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController? _pdfViewController;
  bool loaded = false;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      debugPrint(dir.path);
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  void requestPermission() async {
    await Permission.storage.request();
  }

  @override
  void initState() {
    requestPermission();
    getFileFromUrl(widget.newsletter.pdfLink).then(
      (value) => {
        setState(() {
          if (value != null) {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          } else {
            exists = false;
          }
        })
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Theme(
        data: getTheme(context),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.newsletter.title),
          ),
          body: PDFView(
            filePath: urlPDFPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              //Show some error message or UI
            },
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              setState(() {
                _pdfViewController = vc;
              });
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!;
              });
            },
            onPageError: (page, e) {},
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.chevron_left),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage > 0) {
                      _currentPage--;
                      _pdfViewController!.setPage(_currentPage);
                    }
                  });
                },
              ),
              Text(
                "${_currentPage + 1}/$_totalPages",
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                iconSize: 50,
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    if (_currentPage < _totalPages - 1) {
                      _currentPage++;
                      _pdfViewController!.setPage(_currentPage);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return const Scaffold(
          body: Center(
            child: Text(
              "Loading..",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      } else {
        //Replace Error UI
        return const Scaffold(
          body: Center(
            child: Text(
              "PDF Not Available",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }
}
