import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ornek_8_4/album.dart';
import 'package:flutter_ornek_8_4/input_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: {
        '/' : (context) => const MyHomePage(title: 'Flutter Demo Home Page'),
        '/settings' : (context) => const SettingsPage(),
      },
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
      ogrenciler = [...ogrenciler, yeniOgrenci];
    });
  }


  @override
  Widget build(BuildContext context) {
    //ogrenciler.add('buildden');
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                print('settings');
                Navigator.of(context).pushNamed('/settings');
              },
              icon: const Icon(Icons.settings)),
          TextButton(
            child: const Text('merhaba',
            style: TextStyle(
              color: Colors.black,
            ),
            ),
            onPressed: () {
              print('merhaba');
              },

          ),
        ],
      ),
      body: DefaultTextStyle(
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        child: SinifBilgisi(
          sinif: sinif,
          baslik: baslik,
          ogrenciler: ogrenciler,
          yeniOgrenciEkle: yeniOgrenciEkle,
          child: Stack(
            fit: StackFit.expand,
            children: [
              //ArkaPlan(),
              Positioned(
                top: 10,
                  left: 10,
                  right: 10,
                  bottom: 120,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      print('constraints.maxWidth: ${constraints.maxWidth}');
                      if (constraints.maxWidth > 550){
                        return const Row(
                          children: [
                            Sinif(),
                            Expanded(child: Text('Seçili olan öğrencinin detayları')),
                          ],
                        );
                      } else{
                        return Sinif();
                      }
                    },
                  )
              ),
              const Positioned(
                bottom: 20,
                  left: 10,
                  right: 10,
                  child: OgrenciEkleme()
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('merhaba');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('MERHABA!!')),
          );
        },
        child: const Text('FAB'),
      ),
    );
  }
}

class SinifBilgisi extends InheritedWidget {
  const SinifBilgisi({
    super.key,
    required super.child,
    required this.sinif,
    required this.baslik,
    required this.ogrenciler,
    required this.yeniOgrenciEkle,
  });

  final int sinif;
  final String baslik;
  final List<String> ogrenciler;
  final void Function(String yeniOgrenci) yeniOgrenciEkle;


  static SinifBilgisi of(BuildContext context) {
    final SinifBilgisi? result =
        context.dependOnInheritedWidgetOfExactType<SinifBilgisi>();
    assert(result != null, 'No SinifBilgisi found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(SinifBilgisi old) {
    return sinif != old.sinif
        || baslik != old.baslik
        || ogrenciler != old.ogrenciler
        || yeniOgrenciEkle != old.yeniOgrenciEkle;
  }
}

class Sinif extends StatelessWidget {
  const Sinif({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.star,
              color: Colors.red,
            ),
            Text(
              '${sinifBilgisi.sinif}. Sınıf',
              textScaleFactor: 2,
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
            const Icon(
              Icons.star,
            ),
          ],
        ),
        Container(
          color: Colors.red,
          padding: const EdgeInsets.only(top: 30) + const EdgeInsets.all(4),
          child: Text(
            sinifBilgisi.baslik,
            textScaleFactor: 1.5,
          ),
        ),
        Expanded(child: const OgrenciListesi()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: RichText(
            text: TextSpan(
              text: 'Öğrencileri ',
              children: const <TextSpan>[
                TextSpan(
                  text: 'Yükle',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),

          ),
          onPressed: () async{
            final ogrenciler = SinifBilgisi.of(context).ogrenciler;

            for (final ogrenci in ogrenciler) {
              print('$ogrenci yükleniyor');
              await Future.delayed(const Duration(seconds: 1));
              print('$ogrenci yüklendi');
            }


            print('tüm öğrenciler yüklendi.');
          },
        ),
        RotatedBox(
          quarterTurns: 1,
          child: ElevatedButton(
            child: const Text(
                'Yeni sayfaya git',

            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AlbumPage(),
              ));
                //sor(context);
              },
          ),
        ),
        ElevatedButton(
          child: const Text(
            'Girdi Sayfası',

          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => InputPage(),
            ));
            //sor(context);
          },
        ),
      ],
    );
  }

  Future<void> sor(BuildContext context) async {
    try {
      bool? cevap =
          await Navigator.of(context).push<bool>(MaterialPageRoute(
        builder: (context) {
          return const VideoEkrani('Videoyu beğendiniz mi?');
        },
      ));

      print('cevap geldi: $cevap');
      if (cevap == true) {
        print('beğendi');
        //throw 'hata olsun...';
      } else {
        cevap =
            await Navigator.of(context).push<bool>(MaterialPageRoute(
          builder: (context) {
            return const VideoEkrani(
                'Keşke beğenseniz... Videoyu beğendiniz mi?');
          },
        ));
      }
      if (cevap == true) {
        print('BEĞENDİNİZ!!');
      }
    } catch (e) {
      print('HATA!');
    } finally {
      print('--- is bitti ---');
    }
  }
}

class VideoEkrani extends StatelessWidget {
  final String mesaj;
  const VideoEkrani(this.mesaj, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('pop edecek');
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                const Placeholder(
                  fallbackHeight: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  mesaj
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                      'Evet'
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                      'Hayır'
                  ),
                ),
                //Image.network('https://picsum.photos/200/300'),
              ],
            ),


          ),
      ),
    );
  }
}

class OgrenciEkleme extends StatefulWidget {

  const OgrenciEkleme({
    super.key,
  });


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
    final sinifBilgisi = SinifBilgisi.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: (value) {
            setState(() {
            });
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: ElevatedButton(
            onPressed: controller.text.isEmpty ? null : () {
              final yeniOgrenci = controller.text;
              sinifBilgisi.yeniOgrenciEkle(yeniOgrenci);
              controller.text = '';
            },
            child: const Text(
              'Ekle',
            ),
          ),
        ),


      ],
    );
  }
}

class ArkaPlan extends StatelessWidget {
  const ArkaPlan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: PhysicalModel(
        color: Colors.white,
        shadowColor: Colors.green,
        elevation: 20,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          child: FractionallySizedBox(
            widthFactor: 0.75,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 58.0, vertical: 16.0),
                  child: Image(
                    image: AssetImage('images/homepage_img_8.png'),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OgrenciListesi extends StatelessWidget {
  const OgrenciListesi({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final sinifBilgisi = SinifBilgisi.of(context);
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          key: ValueKey(index),
          leading: Icon(Icons.circle),
          title: Text(
              sinifBilgisi.ogrenciler[index],
            softWrap: false,
            overflow: TextOverflow.fade,
          ),
        );
      },
      itemCount: sinifBilgisi.ogrenciler.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          color: Colors.black,
        );
      },
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings Page',
        ),
      ),
        body: Container(
          child: const Text(
            'Settings Page'
          ),
        ),
    );
  }
}

