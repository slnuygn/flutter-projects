import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

enum Cinsiyet{
  kadin,
  erkek,
  bos,
}

const okullar = ['İlkokul', 'Ortaokul', 'Lise', 'Üniversite'];

class _InputPageState extends State<InputPage> {
  bool? okuldaMisin = false;
  Cinsiyet? cinsiyet = Cinsiyet.bos;
  String? okul;
  double boy = 100;

  TextEditingController yorumController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    yorumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Girdi Sayfası'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                    ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: const Color(0xffeeee00),
                          height: 120.0,
                          alignment: Alignment.center,
                          child: const Text('Fixed height content'),
                        ),
                        Expanded(
                            child: Container(
                              color: const Color(0xffee0000),
                              height: 120.0,
                              alignment: Alignment.center,
                              child: const Text('flexible content'),
                            ),
                        ),
                      ],
                    ),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Checkbox(
                          value: okuldaMisin,
                          onChanged: (value) {
                            setState(() {
                              okuldaMisin = value;
                            });
                          },
                      ),
                      Switch(
                        value: okuldaMisin!,
                        onChanged: (value) {
                          setState(() {
                            okuldaMisin = value;
                          });
                        },
                      ),
                      Text(
                        okuldaMisin == true ? 'Okuldasın' : 'Okulda değilsin',
                      ),
                      Radio<Cinsiyet>(
                          value: Cinsiyet.kadin,
                          groupValue: cinsiyet,
                          onChanged: (value) {
                            setState(() {
                              cinsiyet = value;
                            });
                          },
                      ),
                      Radio<Cinsiyet>(
                        value: Cinsiyet.erkek,
                        groupValue: cinsiyet,
                        onChanged: (value) {
                          setState(() {
                            cinsiyet = value;
                          });
                        },
                      ),
                      Text(cinsiyet.toString()),
                      DropdownButtonFormField<String>(
                        value: okul,
                        items: okullar.map(
                                (e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ),
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            okul = value;
                          });
                        },
                        validator: (value) {
                          if (!okullar.contains(value)) {
                            return 'lütfen okul seçin';
                          }
                        },
                        onSaved: (newValue) {
                          print('okul kaydedildi: $newValue');
                        },
                      ),
                      Text(okul ?? ''),
                      Slider(
                          value: boy,
                          min: 30,
                          max: 300 ,
                          onChanged: (double value) {
                        setState(() {
                          boy = value;
                        });
                      }),
                      Text(
                          boy.toStringAsFixed(2)
                      ),
                      TextFormField(
                        controller: yorumController,
                        onChanged: (value) {
                          setState(() {
                          });
                        },
                        validator: (String? value) {
                          if(value != null) {
                            if(value.isEmpty) {
                              return 'boş bırakılamaz';
                            } else{
                              return null;
                            }
                          } else {
                            return 'null olamaz';
                          }
                        },
                        onSaved: (newValue) {
                          print('yorum kaydediliyor: $newValue');
                        },
                      ),
                      Text(yorumController.text),
                      ElevatedButton(onPressed: () {
                        setState(() {
                          okuldaMisin = false;
                          cinsiyet = Cinsiyet.bos;
                          okul = null;
                          boy = 100;
                          yorumController.text = '';
                        });
                      }, child: Text('Temizle'),),
                      ElevatedButton(onPressed: () {
                        print('Gönder');
                        final icerikUygunMu = formKey.currentState?.validate();
                        if (icerikUygunMu == true) {
                          formKey.currentState?.save();
                          print('sunucuya gidiyor');
                        }
                      }, child: Text('Gönder'),)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),

    );
  }
}
