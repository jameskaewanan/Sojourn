import 'package:audioplayers/audioplayers.dart';


class Globals {

  // ========== Main.dart ==========

  static int mins = 30;
  static int coins = 0;

  // ========== Settings.dart ==========

  static bool ambientValue = false;
  static AudioCache musicCache = AudioCache();
  static AudioPlayer instance = AudioPlayer();

  // ========== Stats.dart ==========

  static int completedHours = 0;
  static int completedCount = 0;


  static double maxY = 200;
  static List<int> daysMins = <int>[0,0,0,0,0,0,0];

  // ========== Locations.dart ==========

  static List<int> inList = <int>[];

  static List<String> locationNumber = <String>[
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
  ];

  static List<String> boatIslandName = <String>[
    "Harold's Hut",
    "Rock and the Boys",
    "Lost Treasure",
    "Light House",
    "Mayan Temple",
    "Krakatoa",
  ];

  static List<String> boatIslandDesc = <String>[
    "Who's Harold? Nobody knows... But his house is pretty nice though.",
    "Cracking open a cold one with the boys.",
    "Imagine just leaving this treasure here out in the open.",
    "Many would have been lost to these waters if it wasn't for these lighthouses.",
    "Make your sacrifices here and we'll consider giving you more coins :).",
    "I suggest you run.",
  ];

  // ========== Timer.dart ==========

  static int location = 0;
  static String theme = 'theme_boat';
  static String defaultDisplayIMG = 'assets/theme_boat/images/waveboat.png';
  static String displayIMG = 'assets/theme_boat/images/waveboat.png';

  static int coinsEarned = 0;

  static String returnText = "CANCEL VOYAGE";

}