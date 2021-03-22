import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:employeemanager/models/manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';



class QrGenerator extends StatefulWidget {

  final Manager manager;

  QrGenerator({this.manager});

  @override
  _QrGeneratorState createState() => _QrGeneratorState(manager: manager);
}

class _QrGeneratorState extends State<QrGenerator> {

  final Manager manager ;
  GlobalKey _globalKey = new GlobalKey();


  _QrGeneratorState({this.manager});

  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 60.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  String _inputErrorText;
  final TextEditingController _textController =  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _captureAndSharePng,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<void> _captureAndSharePng() async {

   final painter = QrPainter(data: manager.documentId, version: QrVersions.auto, color: Colors.white,gapless: true);

   Directory tempDir = await getTemporaryDirectory();
   String tempPath = tempDir.path;
   final ts = DateTime.now().millisecondsSinceEpoch.toString();
   String path = '$tempPath/$ts.png';
   final picData = await painter.toImageData(4096,   format: ui.ImageByteFormat.png);
   await writeToFile(picData, path);

   await Share.shareFiles(
       [path],
       mimeTypes: ["image/png"],
       subject: 'My QR code',
       text: 'Please scan me'
   );
    /* try {
      RenderRepaintBoundary boundary = globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.png').create();
      await file.writeAsBytes(pngBytes);

      final channel = const MethodChannel('channel:me.alfian.share/share');
      channel.invokeMethod('shareFile', 'image.png');

    } catch(e) {
      print(e.toString());
    }*/
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;
    return  Container(
      color: const Color(0xFFFFFFFF),
      child:  Column(
        children: <Widget>[

          Expanded(
            child:  Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: manager.documentId,
                  size: 0.42 * bodyHeight,


                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  writeToFile(ByteData data, String path) async{
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes)
    );
  }

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
      _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
}
