import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MyListBuilder extends StatefulWidget {
  MyListBuilder({Key? key}) : super(key: key);

  @override
  State<MyListBuilder> createState() => _MyListBuilderState();
}

class _MyListBuilderState extends State<MyListBuilder> {
  List pets = [];
  bool isLoading = true;
  void fetchPets() async {
    var url = Uri.https("fakestoreapi.com", "/products");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = convert.jsonDecode(response.body);
      print("Fetching");
      setState(() {
        pets = items;
        isLoading = false;
        print("Fetch Finished");
      });
    } else {
      print("Can not Fetch");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchPets();
    if (isLoading == true) {
      return Material(
        child: Center(
            child: CircularProgressIndicator(
                color: Color.fromARGB(255, 161, 156, 156))),
      );
    } else {
      return Material(
        child: ListView.builder(
          itemCount: pets.length,
          itemBuilder: (context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 4),
              color: Color.fromARGB(255, 233, 228, 228),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    backgroundImage: NetworkImage(pets[index]['image']),
                    radius: 20,
                  ),
                ),
                Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          pets[index]['title'],
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 30),
                        ),
                        //Text(
                        //pets[index]['price'],
                        //),
                        // Text(
                        //   pets[index]['rating'],
                        // ),
                      ],
                    )),
                Expanded(
                  flex: 2,
                  child: IconButton(
                    onPressed: (() => null),
                    icon: Icon(Icons.shopping_cart_sharp),
                  ),
                ),
              ]),
            );
          },
        ),
      );
    }
  }
}
