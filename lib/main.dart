import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hochzeitds_web/button.dart';

import 'package:hochzeitds_web/storage_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:popover/popover.dart';

import 'firebase_options.dart';

main() async {
  /*WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/

  runApp(const MaterialApp(
    home: Directionality(
      textDirection: TextDirection
          .ltr, // or TextDirection.rtl based on your app's language
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool categoriesButtonVisible = false;

  bool imagePicked = false;
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];
  List<int> imageFiles = [];
  List<Uint8List> imagesAsByte = [];

  resetPage() {
    print("reset Page pressd");
    setState(() {
      imageFileList = [];
      imagesAsByte = [];
      imageFiles = [];
      imagePicked = false;
      categoriesButtonVisible = false;
    });
  }

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    for (var element in imageFileList!) {
      imagesAsByte.add(await element.readAsBytes());
      if (imageFileList!.isNotEmpty) {
        categoriesButtonVisible = true;
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        alignment: Alignment.bottomRight,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupGo(imageFileList, resetPage),
            const SizedBox(
              width: 10,
            ),
            const PopupInfo(),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            image: AssetImage('assets/background_small.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                children: [
                  const Center(
                    child: Text(
                      "Bilderseite der Hochzeit von David und Sophia",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  Container(
                      color: Colors.white70,
                      height: 10,
                      width: double.infinity),
                  const SizedBox(
                    height: 28,
                  ),
                  CupertinoButton.filled(
                      child: Container(
                          height: 20,
                          child: const Text("Drücke, um Bilder auszuwählen")),
                      onPressed: () {
                        selectImages();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          itemCount: imageFileList!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: (() {
                                imageFileList?.removeAt(index);
                                if (imageFileList!.isEmpty) {
                                  categoriesButtonVisible = false;
                                }
                                setState(() {});
                              }),
                              child: Image.memory(imagesAsByte[index],
                                  fit: BoxFit.cover),
                            );
                          }),
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedOpacity(
                        opacity: !categoriesButtonVisible ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          height: !categoriesButtonVisible ? 320.0 : 0.0,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Noch kein Bild hinzugefügt",
                              style: TextStyle(
                                  fontSize: 25,
                                  backgroundColor: Colors.white70,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                          opacity: categoriesButtonVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: categoriesButtonVisible ? 250.0 : 0.0,
                              alignment: Alignment.centerRight,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CategoryButton(),
                                      CategoryButton(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CategoryButton(),
                                      CategoryButton(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CategoryButton(),
                                      CategoryButton(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CategoryButton(),
                                      CategoryButton(),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CategoryButton(),
                                      CategoryButton(),
                                    ],
                                  ),
                                ],
                              ))),
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class PopupInfo extends StatelessWidget {
  const PopupInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red.withOpacity(0),
      foregroundColor: Colors.black87,
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (context) => Container(
            padding: const EdgeInsets.all(10),
            child: const Column(
              children: [
                Text(
                  "Mit diesen einfachen Schritten machst du den Tag für David und Sophia unvergesslich:",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "1. Drücke auf den blauen Knopf, um Bilder aus der deiner Galerie auszuwählen",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "2. Falsches Bild ausgewählt? Drücke einfach auf das falsche Bild, um es zu löschen",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "3. Wähle die Kategorien, die zu deinem Bild passen. Durch das Drücken auf die Kategorie wird diese aus-oder abgewählt",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "4. Zufrieden? Dann drücke den grünen Haken, um die Bilder hochzuladen. WICHTIG! Nach Drücken des Hakens gibt es kein zurück mehr",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          direction: PopoverDirection.top,
          width: 300,
          height: 420,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: const Icon(
        Icons.info,
        size: 60,
      ),
    );
  }
}

// ignore: must_be_immutable
class PopupGo extends StatelessWidget {
  List<XFile>? imageFileList;

  Function resetPage;

  PopupGo(this.imageFileList, this.resetPage, {super.key});

  @override
  Widget build(BuildContext context) {
    StorageFunctions storageFunctions = StorageFunctions(resetPage);
    return FloatingActionButton(
      backgroundColor: Colors.red.withOpacity(0),
      onPressed: () {
        showPopover(
          context: context,
          bodyBuilder: (contextR) => Container(
              padding: const EdgeInsets.all(10),
              child: OutlinedButton(
                onPressed: () {
                  storageFunctions.uploadImageToFirebaseStorage(imageFileList!);

                  showDialog<void>(
                    context: contextR,
                    barrierDismissible: false, // user must tap button!
                    builder: (BuildContext context) {
                      Future.delayed(const Duration(seconds: 5), () {
                        Navigator.of(context).pop();
                        Navigator.of(contextR).pop();
                      });

                      return AlertDialog(
                        content: Lottie.asset('assets/wedding_ring.json'),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text("Bist du dir sicher? Dann los gehts"),
              )),
          direction: PopoverDirection.top,
          width: 200,
          height: 120,
          arrowHeight: 15,
          arrowWidth: 30,
        );
      },
      child: const CircleAvatar(
        backgroundColor: Colors.green,
        radius: 25,
        child: Icon(
          color: Colors.white70,
          Icons.check,
          size: 50,
        ),
      ),
    );
  }
}
