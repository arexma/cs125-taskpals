import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'package:theme_provider/theme_provider.dart';

class Pets extends StatefulWidget {
  final UserDataFirebase user;
  const Pets({super.key, required this.user});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  final List<String> petNames = [
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

  bool petSearch(List<String> userPets, String pet) {
    bool owns = false;

    if (userPets.contains(pet)) {
      return !owns;
    }

    return owns;
  }

  @override
  Widget build(BuildContext context) {
    List<String> userPets = List<String>.from(
        widget.user.queryByField(['pals_collected'])['pals_collected']);
    String backgroundPath =
        ThemeProvider.themeOf(context).data == ThemeData.dark()
            ? 'lib/assets/background/night.gif'
            : 'lib/assets/background/day.gif';

    print(userPets);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
            itemCount: petNames.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: GridTile(
                  child: petSearch(userPets, petNames[index]) == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  'lib/assets/pets/${petNames[index]}.gif'),
                              width: 80,
                              height: 80,
                            ),
                            Text(
                              petNames[index],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .hintColor,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                    colors: [Colors.black, Colors.transparent],
                                    stops: [1.0, 1.0]).createShader(bounds);
                              },
                              blendMode: BlendMode.srcIn,
                              child: Image(
                                image: AssetImage(
                                    'lib/assets/pets/${petNames[index]}.gif'),
                                width: 50,
                                height: 50,
                              ),
                            ),
                            Text(
                              petNames[index],
                              style: TextStyle(
                                color: ThemeProvider.themeOf(context)
                                    .data
                                    .hintColor,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            }),
      ],
    );
  }
}
