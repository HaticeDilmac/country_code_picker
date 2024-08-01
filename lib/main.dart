import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Country country = CountryParser.parseCountryCode('TR');
  void showPicker() {
    showCountryPicker(
        context: context,
        favorite: ['TR', 'DE'], //favorite countries
        exclude: ['CN'], //the ruined country
        countryListTheme: CountryListThemeData(
            //bottomSheet properties
            backgroundColor: const Color.fromARGB(255, 227, 227, 227),
            searchTextStyle: const TextStyle(
              color: Colors.black,
            ),
            inputDecoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search),
                hintText: 'Enter your country name'),
            borderRadius: BorderRadius.circular(10),
            bottomSheetHeight: 500),
        onSelect: (country) {
          setState(() {
            this.country = country; //default country picker country show
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Country Code Example',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: TextFormField(
            cursorColor: Colors.purple,
            keyboardType: TextInputType.phone,
            onFieldSubmitted: (phoneNumber) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('+${country.phoneCode}$phoneNumber')));
            },
            decoration: InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
                filled: true,
                focusColor: const Color.fromARGB(255, 224, 218, 224),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 0,
                      color: Color.fromARGB(255, 224, 218, 224),
                    )),
                fillColor: const Color.fromARGB(255, 224, 218, 224),
                prefixIcon: GestureDetector(
                  onTap: () {
                    showPicker();
                  },
                  child: Container(
                    height: 50,
                    width: 80,
                    alignment: Alignment.center,
                    //countries flay and phone code
                    child: Text('${country.flagEmoji} +${country.phoneCode}'),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
