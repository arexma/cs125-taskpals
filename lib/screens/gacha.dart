/*
Where the user can use in-app currency to roll for pets after earning their wage from tasks
*/

import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'package:theme_provider/theme_provider.dart';

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
    "Jolteo",
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
    String temp = queryCoins();
    coins = int.parse(temp);
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
                  child: Text(
                    "$coins Coins",
                    style: const TextStyle(fontSize: 20, color: Colors.red),
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
                          const Text("5"),
                          const Text("Summon x1"),
                        ]),
                        onPressed: () {
                          if (coins >= 5) {
                            print("summoning 1 time(s) -- $coins");
                            subtractCoins(5);
                          }
                          print("failed to summon 1 time(s) -- $coins");
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
                          const Text("50"),
                          const Text("Summon x10"),
                        ]),
                        onPressed: () {
                          if (coins >= 50) {
                            print("summoning 10 time(s) -- $coins");
                            subtractCoins(50);
                          }
                          print("failed to summon 10 time(s) -- $coins");
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

  // obtains tasks from database and turns into list (string)
  String queryCoins() {
    Map<String, dynamic> query = widget.user.queryByField(["coins"]);
    return query["coins"] ?? "0";
  }

  void subtractCoins(int amount) {
    Map<String, dynamic> db = widget.user.queryByField(['coins']);
    String tempCoinsString = db["coins"];
    int tempCoins = int.parse(tempCoinsString);
    tempCoins -= amount;
    db["coins"] = tempCoins;
    widget.user.updateDatabase(db);
  }
}
