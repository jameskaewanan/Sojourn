import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'globals.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsState createState() {
    return _SettingsState();
  }
}


class _SettingsState extends State<SettingsPage> {

  void playLoopedMusic() async {
    Globals.musicCache = AudioCache(prefix: "assets/theme_boat/audio/");
    Globals.instance = await Globals.musicCache.loop("waves.wav");
    await Globals.instance.setVolume(1);
    print("audio is playing");
  }

  void pauseMusic() {
    if (Globals.instance != null) {
      Globals.instance.pause();
      print("audio is paused");
    }
  }

  void toggleMusic() {
    if (Globals.ambientValue != false) {
      playLoopedMusic();
    } else {
      pauseMusic();
    }
  }

  aboutDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: Center(child: Text("ABOUT")),
      content: Text('''
      Sojourn is a pomodoro style app in the theme of a boat embarking on a journey. \n
      This app was created as part of Mahidol University International College's Mobile Application Development course.
      ''', textAlign: TextAlign.center),
      actions: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.20,
              child: RaisedButton(
                child: new Text(
                  'CLOSE',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.lightBlue,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xffffffff), Color.fromARGB(
                  220, 56, 192, 255)
              ],
              begin: FractionalOffset(1, 0.8)
          )
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(120, 56, 192, 255),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear_rounded),
          ),
          title: Text(
            "SETTINGS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.brush,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    title: 'Theme (Coming Soon)',
                    subtitle: "Select the theme for Sojourn",
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.audiotrack,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    title: 'Ambient Audio',
                    subtitle: "Toggle ambient audio on or off",
                    trailing: Switch.adaptive(
                      value: Globals.ambientValue,
                      onChanged: (value) {
                        setState(() {
                          Globals.ambientValue = value;
                        });
                        toggleMusic();
                      },
                    ),
                  ),
                ],
              ),

              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return aboutDialog();
                        },
                      );
                    },
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    title: 'About',
                    subtitle: "Learn more about Sojourn",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}