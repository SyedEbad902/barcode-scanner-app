import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class BarCodeGenerator extends StatefulWidget {
  const BarCodeGenerator({super.key});

  @override
  State<BarCodeGenerator> createState() => _BarCodeGeneratorState();
}

class _BarCodeGeneratorState extends State<BarCodeGenerator> {
  String? barcodeValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181818),

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff181818),

        automaticallyImplyLeading: false,
        title: const Text(
          'Bar Code Generator',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff0066b2),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.qr_code_scanner_outlined,
              color: Color(0xff0066b2),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(color: Color(0xff0066b2)),
              cursorColor: Color(0xff0066b2),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0066b2)),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Enter the text to generate the QR code',
                hintStyle: TextStyle(color: Color(0xff0066b2)),

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff0066b2)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  barcodeValue = value;
                });
              },
            ),
            SizedBox(height: 20),
            if (barcodeValue != null)
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                // width: MediaQuery.of(context).size.width * 0.7,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Color(0xff0066b2), width: 3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: PrettyQrView.data(data: barcodeValue!),
              ),
          ],
        ),
      ),
    );
  }
}
