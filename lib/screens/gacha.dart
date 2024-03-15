/*
Where the user can use in-app currency to roll for pets after earning their wage from tasks
*/

import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'package:theme_provider/theme_provider.dart';
import 'dart:math' as math;

class GachaPageStarter extends StatefulWidget {
  final UserDataFirebase user;
  const GachaPageStarter({super.key, required this.user});

  @override
  State<GachaPageStarter> createState() => GachaPage();
}

class GachaPage extends State<GachaPageStarter> {
  final List<String> allPals = [
    "Abra",
    "Aerodactyl",
    "Alakazam",
    "Arbok",
    "Arcanine",
    "Articuno",
    "Beedrill",
    "Bellsprout",
    "Blastoise",
    "Bulbasaur",
    "Butterfree",
    "Caterpie",
    "Chansey",
    "Charizard",
    "Charmander",
    "Charmeleon",
    "Clefable",
    "Clefairy",
    "Cloyster",
    "Cubone",
    "Dewgong",
    "Diglett",
    "Ditto",
    "Dodrio",
    "Doduo",
    "Dragonair",
    "Dragonite",
    "Dratini",
    "Drowzee",
    "Dugtrio",
    "Eevee",
    "Ekans",
    "Electabuzz",
    "Electrode",
    "Exeggcute",
    "Exeggutor",
    "Farfetch’d",
    "Fearow",
    "Flareon",
    "Gastly",
    "Gengar",
    "Geodude",
    "Gloom",
    "Golbat",
    "Goldeen",
    "Golduck",
    "Golem",
    "Graveler",
    "Grimer",
    "Growlithe",
    "Gyarados",
    "Haunter",
    "Hitmonchan",
    "Hitmonlee",
    "Horsea",
    "Hypno",
    "Ivysaur",
    "Jigglypuff",
    "Jolteon",
    "Jynx",
    "Kabuto",
    "Kabutops",
    "Kadabra",
    "Kakuna",
    "Kangaskhan",
    "Kingler",
    "Koffing",
    "Krabby",
    "Lapras",
    "Lickitung",
    "Machamp",
    "Machoke",
    "Machop",
    "Magikarp",
    "Magmar",
    "Magnemite",
    "Magneton",
    "Mankey",
    "Marowak",
    "Meowth",
    "Metapod",
    "Mew",
    "Mewtwo",
    "Moltres",
    "Mr. Mime",
    "Muk",
    "Ninetales",
    "Oddish",
    "Omanyte",
    "Omastar",
    "Onix",
    "Paras",
    "Parasect",
    "Persian",
    "Pidgeot",
    "Pidgeotto",
    "Pidgey",
    "Pikachu",
    "Pinsir",
    "Poliwag",
    "Poliwhirl",
    "Poliwrath",
    "Ponyta",
    "Porygon",
    "Primeape",
    "Psyduck",
    "Raichu",
    "Rapidash",
    "Raticate",
    "Rattata",
    "Rhydon",
    "Rhyhorn",
    "Sandshrew",
    "Sandslash",
    "Scyther",
    "Seadra",
    "Seaking",
    "Seel",
    "Shellder",
    "Slowbro",
    "Slowpoke",
    "Snorlax",
    "Spearow",
    "Squirtle",
    "Starmie",
    "Staryu",
    "Tangela",
    "Tauros",
    "Tentacool",
    "Tentacruel",
    "Vaporeon",
    "Venomoth",
    "Venonat",
    "Venusaur",
    "Victreebel",
    "Vileplume",
    "Voltorb",
    "Vulpix",
    "Wartortle",
    "Weedle",
    "Weepinbell",
    "Weezing",
    "Wigglytuff",
    "Zapdos",
    "Zubat"
  ];
  int coins = 0;

  @override
  void initState() {
    super.initState();
    coins = queryCoins();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      "$coins Coins",
                      style: const TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ),
              ),
              const Expanded(
                  flex: 7,
                  child: Image(
                      alignment: Alignment.center,
                      image: AssetImage('lib/assets/gacha_pic.jpg'))),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColorDark;
                              }
                              return ThemeProvider.themeOf(context)
                                  .data
                                  .primaryColorLight;
                            },
                          ),
                        ),
                        child: Row(children: [
                          Image.asset('lib/assets/coin.png',
                              height: 40, fit: BoxFit.cover),
                          const Text(" 5 "),
                          const Text("Summon x1"),
                        ]),
                        onPressed: () {
                          if (coins >= 5) {
                            debugPrint("summoning 1 time(s) -- $coins");
                            summonPals(1);
                            subtractCoins(5);
                          } else {
                            debugPrint("failed to summon 1 time(s) -- $coins");
                          }
                        },
                      ),
                    ),
                    Center(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return ThemeProvider.themeOf(context)
                                    .data
                                    .primaryColorDark;
                              }
                              return ThemeProvider.themeOf(context)
                                  .data
                                  .primaryColorLight;
                            },
                          ),
                        ),
                        child: Row(children: [
                          Image.asset('lib/assets/coin.png',
                              height: 40, fit: BoxFit.cover),
                          const Text(" 50 "),
                          const Text("Summon x10"),
                        ]),
                        onPressed: () {
                          if (coins >= 50) {
                            debugPrint("summoning 10 time(s) -- $coins");
                            summonPals(10);
                            subtractCoins(50);
                          } else {
                            debugPrint("failed to summon 10 time(s) -- $coins");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int queryCoins() {
    return widget.user.queryByField(['currency'])['currency'];
  }

  String getRandomPal() {
    math.Random random = math.Random();
    int index = random.nextInt(allPals.length);
    String randomPal = allPals[index];

    return randomPal;
  }

  void summonPals(int amount) {
    Map<String, dynamic> db = widget.user.queryByField(['pals_collected']);
    List<String> summonedList = [];
    int i = 0;
    for (i; i < amount; i++) {
      String tempPal = getRandomPal();
      while (db['pals_collected'].contains(tempPal)) {
        tempPal = getRandomPal();
      }
      db['pals_collected'].add(tempPal);
      summonedList.add(tempPal);
      debugPrint(tempPal);
    }

    widget.user.updateDatabase(db);
    showSummonedPals(summonedList);
  }

  void subtractCoins(int amount) {
    Map<String, dynamic> db = widget.user.queryByField(['currency']);
    int tempCoins = db['currency'];
    tempCoins -= amount;
    db['currency'] = tempCoins;
    widget.user.updateDatabase(db);
    setState(() {
      coins = tempCoins;
    });
  }

  void showSummonedPals(List<String> summonedPals) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Summoned Pals'),
          content: SizedBox(
            width: 300,
            height: 400,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
              itemCount: summonedPals.length,
              itemBuilder: (BuildContext context, int index) {
                return GridTile(
                  child: Column(
                    children: [
                      Image(
                        image: AssetImage(
                            'lib/assets/pets/${summonedPals[index]}.gif'),
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        summonedPals[index],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
