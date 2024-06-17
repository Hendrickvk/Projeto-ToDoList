import 'package:flutter/material.dart';
import 'package:flutter_to_do_list/const/colors.dart';
import 'package:flutter_to_do_list/data/auth_data.dart';
import 'package:flutter_to_do_list/screen/add_note_screen.dart';
import 'package:flutter_to_do_list/screen/login.dart';
import 'package:flutter_to_do_list/widgets/stream_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: AddButton(),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            // Handle scroll notifications if needed
            return true;
          },
          child: Column(
            children: [
              Stream_note(false), // Assuming StreamNote widget handles display of notes
              Text(
                'Feitos',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color.fromARGB(255, 100, 100, 100),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stream_note(true), // Assuming StreamNote widget handles display of notes
            ],
          ),
        ),
      ),
    );
  }

  Widget AddButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
            },
            backgroundColor: custom_green,
            child: Icon(Icons.add, size: 30),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: FloatingActionButton(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LogIN_Screen(),
              ));
              AuthenticationRemote().logout();
            },
            backgroundColor: Colors.red,
            child: Icon(Icons.logout, size: 30),
          ),
        ),
      ],
    );
  }
}
