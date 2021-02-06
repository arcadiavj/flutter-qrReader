import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';
import 'package:qr_reader/widgets/custom_navigatorBar.dart';
import 'package:qr_reader/widgets/scan_boton.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever),
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false);
                DBProvider.db.deleteAllScans();
              })
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //obtener el current opt
    final uiProvider = Provider.of<UiProvider>(context);
    //camiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectedMenuOpt;

    //final tempScan = new ScanModel(valor: 'http://google.com');
    //usar el scanlistprovider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.deleteAllScans().then(print);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
        break;
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
        break;
      default:
        MapasPage();
    }
  }
}
