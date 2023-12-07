import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multiple_image_camera/camera_file.dart';
import 'package:multiple_image_camera/multiple_image_camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    List<MediaModel> imageList = <MediaModel>[];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        imageList: imageList,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<MediaModel> imageList;
  const MyHomePage({super.key, required this.imageList});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<MediaModel> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text("Capture"),
            onPressed: () async {
              MultipleImageCamera.capture(
                context: context,
              ).then((value) {
                setState(() {
                  images = value;
                });
              });
            },
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Image.file(File(images[index].file.path));
                }),
          )
        ],
      ),
    );
  }
}
