import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var sinif = 5;
  var baslik = 'Ogrenciler';
  var ogrenciler = ['Ali', 'Ayse', 'Can'];

  void yeniOgrenciEkle(String yeniOgrenci) {
    setState(() {
      ogrenciler.add(yeniOgrenci);
    });
  }


  @override
  Widget build(BuildContext context) {
    //ogrenciler.add('buildden');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Sinif(
          sinif: sinif,
          baslik: baslik,
          ogrenciler: ogrenciler,
          yeniOgrenciEkle: yeniOgrenciEkle,
      ),
    );
  }
}

class Sinif extends StatelessWidget {
  const Sinif({
    super.key,
    required this.sinif,
    required this.baslik,
    required this.ogrenciler,
    required this.yeniOgrenciEkle,
  });

  final int sinif;
  final String baslik;
  final List<String> ogrenciler;
  final void Function(String yeniOgrenci) yeniOgrenciEkle;

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text(
              '$sinif. Sınıf',
              textScaleFactor: 2,
            ),
            Icon(
              Icons.star,
            ),
          ],
        ),
        Text(
          baslik,
          textScaleFactor: 1.5,
        ),
        OgreciListesi(ogrenciler: ogrenciler),
        OgrenciEkleme(yeniOgrenciEkle: yeniOgrenciEkle),
      ],
    );
  }
}

class OgrenciEkleme extends StatefulWidget {

  const OgrenciEkleme({
    super.key, required this.yeniOgrenciEkle,
  });

  final void Function(String yeniOgrenci) yeniOgrenciEkle;

  @override
  State<OgrenciEkleme> createState() => _OgrenciEklemeState();
}

class _OgrenciEklemeState extends State<OgrenciEkleme> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {
            });
          },
        ),
        ElevatedButton(
          onPressed: controller.text.isEmpty ? null : () {
              final yeniOgrenci = controller.text;
              widget.yeniOgrenciEkle(yeniOgrenci);
              controller.text = '';
            /*
            setState(() {
              ogrenciler.add('yeni');
            }); */
          },
          child: Text(
            'Ekle',
          ),
        ),
      ],
    );
  }
}

class OgreciListesi extends StatelessWidget {
  const OgreciListesi({
    super.key,
    required this.ogrenciler,
  });

  final List<String> ogrenciler;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final o in ogrenciler)
          Text(
            o
          ),
      ],
    );
  }
}
