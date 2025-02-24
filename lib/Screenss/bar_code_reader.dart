import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'bar_code_generator.dart';

class BarCodeReader extends StatefulWidget {
  const BarCodeReader({super.key});

  @override
  State<BarCodeReader> createState() => _BarCodeReaderState();
}

class _BarCodeReaderState extends State<BarCodeReader> {
  dispose() {
    super.dispose();

    MobileScannerController().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Code Reader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code),
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
            // border: Border.all(color: Colors.black, width: 1),
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
                      title: Text(barcodes.first.rawValue ?? ''),
                      content: Image.memory(image),
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
