import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bar_code_generator.dart';

class BarCodeReader extends StatefulWidget {
  const BarCodeReader({super.key});

  @override
  State<BarCodeReader> createState() => _BarCodeReaderState();
}

class _BarCodeReaderState extends State<BarCodeReader> {
  @override
  dispose() {
    super.dispose();

    MobileScannerController().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),
      appBar: AppBar(
        backgroundColor: Color(0xff181818),

        title: const Text(
          'Bar Code Reader',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0066b2),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code, color: Color(0xff0066b2)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarCodeGenerator()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(0xff0066b2), width: 2),
          ),
          clipBehavior: Clip.antiAlias,
          child: MobileScanner(
            controller: MobileScannerController(
              returnImage: true,
              detectionSpeed: DetectionSpeed.noDuplicates,
            ),
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;

              // for (final barcode in barcodes) {

              // }

              if (image != null) {
                // Do something with the image
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: GestureDetector(
                        onTap: () {
                          launchUrl(
                            Uri.http(
                              barcodes.first.rawValue!.split("https://").last,
                            ),
                          );
                        },
                        child: Text(
                          barcodes.first.rawValue ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      content: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),

                          image: DecorationImage(
                            image: MemoryImage(image),
                            fit: BoxFit.cover,
                          ),
                        ),

                        height: 200,
                        width: double.infinity,
                        // child: Image.memory(image)
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
