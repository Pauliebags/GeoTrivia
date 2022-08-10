import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/Questions/screens/quizz_screen.dart';
import 'package:provider/provider.dart';
import '../../settings/theme_provider.dart';
import '../ui/shared/color.dart';
dynamic dropdownvalue = 'Europe';
var items = [
  'North America',
  'South America',
  'Africa',
  'Asia',
  'Oceania',
  'World Flags',
  'Europe',
];
class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);
  @override
  _MainMenuState createState() => _MainMenuState();
}
class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor:themeProvider.isDarkMode?Colors.black: AppColor.secondaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            const Center(
              child: Text(
                "GeoTrivia",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Image.asset('assets/images/geotrivia.jpg',
                width: 300.0, height: 300.0),
            Text(
              'Pick your Quiz topic below!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              dropdownColor: Colors.black,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              alignment: AlignmentDirectional.center,
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  dropdownvalue = newValue;
                });
              },
            ),
            Expanded(
              child: Center(
                child: RawMaterialButton(
                  onPressed: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizzScreen(
                                quizzCountry: dropdownvalue,
                              ),
                            ));
                  },
                  shape: const StadiumBorder(),
                  fillColor: AppColor.pripmaryColor,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: Text(
                      "Start the Quiz",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "Made with ❤ by Paul Fitzpatrick",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
