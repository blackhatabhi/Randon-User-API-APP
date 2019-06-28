import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List usersData;
  bool isLoading = true;
  final String url = "https://randomuser.me/api?results=50";

  Future getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    List data = jsonDecode(response.body)['results'];

    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User"),
      ),
      body: Container(
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: usersData == null ? 0 : usersData.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(20.0),
                              child: Image(
                                width: 70.0,
                                height: 70.0,
                                fit: BoxFit.contain,
                                image: NetworkImage(
                                  usersData[index]['picture']['thumbnail'],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    usersData[index]["name"]['first'] +
                                        " " +
                                        usersData[index]["name"]['last'],
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.phone),
                                    title: Text(
                                        "Phone no. :- ${usersData[index]['phone']}"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text(
                                        "Gender :- ${usersData[index]['gender']}"),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.people),
                                    title: Text(
                                        "Age :- ${usersData[index]["dob"]['age']}"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
