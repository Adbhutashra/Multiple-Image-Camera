import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ImagePreviewView extends StatefulWidget {
  final File file;
  final String imageTitle;

  ImagePreviewView(this.file, this.imageTitle, {super.key});

  @override
  _ImagePreviewViewState createState() => _ImagePreviewViewState();
}

class _ImagePreviewViewState extends State<ImagePreviewView> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom, 
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 1,
        title: Text(
          widget.imageTitle,
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 16),
        ),
      ),
      body: InteractiveViewer(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.black,
        child: SafeArea(
          child: SingleChildScrollView(
              reverse: true,
              child: Container(
                
                width: double.infinity,
                

                child: Hero(
                  tag: widget.file.path,
                  child: Image.file(
                    widget.file,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              )),
        ),
      )),
    );
  }

  Future decodeImage() async {
    var decodedImage;

    decodedImage = await decodeImageFromList(widget.file.readAsBytesSync());
    print("------------> ${decodedImage.width}");
    return decodedImage.width.toDouble();
  }
}
