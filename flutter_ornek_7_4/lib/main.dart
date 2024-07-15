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
  int aktifButon = 0;
  String istenenYazi = '';


  bool checkliMi = false;
  String text = '';

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        
        
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            YaziYazmaYeri(istenenYazi : istenenYazi),
            Text(text),
            Checkbox(value: checkliMi,
                onChanged: (value) {
                print(value);
                setState(() {
                  if (value != null) {
                    checkliMi = value;
                  }
                });
                }),
            ElevatedButton(
              onPressed: aktifButon == 0 ? () {
                print('0');
                setState(() {
                  aktifButon = (aktifButon + 1) % 3;
                  istenenYazi = 'sifir';
                });

              } : null,
                child: Text('0'),
            ),
            ElevatedButton(
              onPressed: aktifButon == 1 ? () {
                print('1');
                setState(() {
                  aktifButon = (aktifButon + 1) % 3;
                  istenenYazi = 'bir';
                });
              } : null,
              child: Text('1'),
            ),
            ElevatedButton(
              onPressed: aktifButon == 2 ? () {
                print('2');
                setState(() {
                  aktifButon = (aktifButon + 1) % 3;
                  istenenYazi = 'iki';
                });
              } : null,
              child: Text('2'),
            )
          ],
        ),
      ),

    );
  }
}

class YaziYazmaYeri extends StatefulWidget {
  final String istenenYazi;
  const YaziYazmaYeri({
    super.key, required this.istenenYazi,
  });

  @override
  State<YaziYazmaYeri> createState() => _YaziYazmaYeriState();
}

class _YaziYazmaYeriState extends State<YaziYazmaYeri> {

  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(() {
      print('yeni değer ${controller.text}');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant YaziYazmaYeri oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.istenenYazi != widget.istenenYazi) {
      controller.text = widget.istenenYazi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) {
        print(value);
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            controller.text = '';
          },
        ),
      ),
    );
  }
}
