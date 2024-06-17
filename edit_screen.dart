import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/firestor.dart';
import 'package:flutter_to_do_list/model/notes_model.dart';
import 'package:image_picker/image_picker.dart';

class Edit_Screen extends StatefulWidget {
  final Note _note;

  Edit_Screen(this._note, {Key? key}) : super(key: key);

  @override
  State<Edit_Screen> createState() => _EditScreenState();
}

class _EditScreenState extends State<Edit_Screen> {
  TextEditingController? title;
  TextEditingController? subtitle;
  File? _selectedImage;

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  int indexx = 0;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
  }

  @override
  void dispose() {
    title!.dispose();
    subtitle!.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              titleWidgets(),
              SizedBox(height: 20),
              subtitleWidget(),
              SizedBox(height: 20),
              imagesWidget(),
              SizedBox(height: 20),
              buttonWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: custom_green,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Firestore_Datasource().Update_Note(
              widget._note.id,
              indexx,
              title!.text,
              subtitle!.text,
              _selectedImage?.path,
            );
            Navigator.pop(context);
          },
          child: Text('Atualizar Nota', style: TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar', style: TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 169, 199),
            minimumSize: Size(170, 48),
          ),
          onPressed: _pickImageFromGallery,
          child: Text('Adicionar Imagem da Galeria',
              style: TextStyle(color: Colors.black)),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 169, 199),
            minimumSize: Size(170, 48),
          ),
          onPressed: _pickImageFromCamera,
          child: Text('Adicionar Imagem da Câmera',
              style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget imagesWidget() {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 5 + (_selectedImage != null ? 1 : 0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index < 5) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexx = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 6 : 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: indexx == index ? custom_green : Colors.grey,
                    ),
                  ),
                  width: 140,
                  margin: EdgeInsets.all(8),
                  child: Image.asset('images/${index}.png'),
                ),
              ),
            );
          } else if (_selectedImage != null) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  indexx = index;
                });
              },
              child: Padding(
                padding: EdgeInsets.only(left: 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: indexx == index ? custom_green : Colors.grey,
                    ),
                  ),
                  width: 140,
                  margin: EdgeInsets.all(8),
                  child: Image.file(_selectedImage!),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget titleWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Título',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget subtitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          maxLines: 3,
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Descrição',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: custom_green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage == null) return;

    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }
}
