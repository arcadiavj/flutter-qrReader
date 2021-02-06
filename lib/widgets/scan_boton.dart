import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.filter_center_focus),
        onPressed: () async {
          String barcodeScansRes = await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF', 'CANCELAR', false, ScanMode.QR);

          //final barcodeScansRes = 'geo:-32.899894714340384,-68.78799138010658';
          if (barcodeScansRes == -1) {
            return;
          }
          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          scanListProvider.nuevoScan(barcodeScansRes);
          //scanListProvider.nuevoScan('geo:12.12.35,234,342');
          //scanListProvider.cargarScansPorTipo('geo');
          final nuevoScan = await scanListProvider.nuevoScan(barcodeScansRes);
          launchURL(context, nuevoScan);
        });
  }
}
