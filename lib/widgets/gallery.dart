import 'dart:io';

import 'package:servicioscommune/widgets/columnBuilder.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class Galery extends StatefulWidget {
  Function(List<File>) list;
  Galery({required this.list});

  @override
  State<Galery> createState() => _GaleryState();
}

class _GaleryState extends State<Galery> {
  double w = 0, h=0;
  List<File> listaImagenes = [];
  bool fromGallery = false;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          // Text("Galeria"),
          Container(
            child: ColumnBuilder(
              itemCount: listaImagenes.length,
              itemBuilder: (c, i) {
                return imageViewer(i);
              },
              finalWidget: listaImagenes.length < 3
                  ? IconButton.outlined(
                      onPressed: () {
                        _alert();
                      },
                      icon: Icon(FontAwesomeIcons.plus))
                  : SizedBox(),
            ),
          )
        ],
      ),
    );
  }

  Widget imageViewer(int i) {
    File fotoId = listaImagenes[i];

    return InkWell(
        onTap: () => {},
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: w * 0.75,
            height: 250,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: w - 100,
                  child: Image.file(
                    fotoId,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                      //width: 50,
                      child: InkWell(
                    onTap: () => {
                      setState(() {
                        listaImagenes.removeAt(i);
                        this.widget.list(listaImagenes);
                      })
                    }, // getImage(),
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        child: const Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.red,
                          size: 15,
                        )),
                  )),
                ),
              ],
            )));
  }

  _alert() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              // title: Container(child: Text("")), //Row(children: <Widget>[Icon(FontAwesomeIcons.checkCircle, color: Colors.green),Text("Envio éxitoso"),],),
              content: Container(
                width: w - 170,
                height: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                        onTap: () async {
                          File? _file;
                          fromGallery=false;
                          var filee = await getImage(_file);

                          Navigator.of(context).pop();
                          setState(() {
                            listaImagenes.add(filee);
                            this.widget.list(listaImagenes);
                          });
                        },
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 10),
                            Icon(
                              FontAwesomeIcons.camera,
                              color: Color(0xFF2d4e3d),
                            ),
                            SizedBox(height: 10),
                            Text("Cámara")
                          ],
                        )),
                    InkWell(
                        onTap: () async {
                          File? _file;
                          fromGallery=true;
                          var filee = await getImage(_file);

                          // listFotos?.add(filee);
                          Navigator.of(context).pop();
                          setState(() {
                            listaImagenes.add(filee);
                            this.widget.list(listaImagenes);
                          });
                        },
                        child: const Column(
                          children: [
                            SizedBox(height: 10),
                            Icon(FontAwesomeIcons.images,
                                color: Color(0xFF2d4e3d)),
                            SizedBox(height: 10),
                            Text("Galería")
                          ],
                        )),
                  ],
                ),
              ));
        });
  }

  Future getImage(File? _fotoId) async {
    if (fromGallery) {
      await picker
          .pickImage(source: ImageSource.gallery, imageQuality: 10)
          .then((value) {
        setState(() {
          _fotoId = File(value!.path);
          //urlPhoto = value.path;
        });
      });
      return _fotoId;
    } else {
      await picker
          .pickImage(source: ImageSource.camera, imageQuality: 10)
          .then((value) {
        setState(() {
          _fotoId = File(value!.path);
          //urlPhoto = value.path;
        });
      });
      return _fotoId;
    }
  }
}
