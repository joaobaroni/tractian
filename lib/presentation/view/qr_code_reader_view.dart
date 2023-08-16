import 'package:flutter/material.dart';
import 'package:tractian/infrastructure/infrastructure.dart';

class QRCodeReaderView extends StatefulWidget {
  const QRCodeReaderView({super.key});

  @override
  State<QRCodeReaderView> createState() => _QRCodeReaderViewState();
}

class _QRCodeReaderViewState extends State<QRCodeReaderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorPalette.primary,
        iconTheme: context.theme.iconTheme.copyWith(color: context.colorPalette.onPrimary),
        title: Text(
          'QR Code Reader',
          style: context.textTheme.titleLarge!.copyWith(color: context.colorPalette.onPrimary),
        ),
        centerTitle: true,
      ),
      body: SizedBox(),
    );
  }
}
