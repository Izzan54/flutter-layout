import 'dart:convert';
import 'package:exercise4/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBar(),
    );
  }
}

class ChatBar extends StatefulWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> {
  List<userMsg> _chat = [];

  // get child => null;

  Future<List<userMsg>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString("assets/users.json");
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => userMsg.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat Messages Status"),

        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasData) {
              var _chat = data.data as List<userMsg>;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[                 
                              Padding(padding: EdgeInsets.only(right: 20),
                              child: CircleAvatar(                                
                                backgroundImage: NetworkImage(
                                    _chat[index].avatar.toString()),
                                    radius: 40,
                              ),
                              )   ,      
                              
                              Expanded(
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: 
                                       Row(
                                      children: [
                                      Text(_chat[index].firstname.toString(),
                                      style: TextStyle(fontSize: 30,
                                      fontWeight: FontWeight.bold),),
                                    Text(_chat[index].lastname.toString(),
                                    style: TextStyle(fontSize: 30,
                                    fontWeight: FontWeight.bold),),
                                    ],),
                                    ),
  
                                    Text(_chat[index].username.toString(),
                                    style: TextStyle(fontSize: 20),),
                                    Text(_chat[index].status.toString(),
                                    style: TextStyle(fontSize: 20),),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_chat[index].lastseentime.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),),
                                      CircleAvatar(
                                        backgroundColor:Colors.grey[300] ,
                                        child: Text(_chat[index].messages == null ? "":_chat[index].messages.toString(),
                                    style: TextStyle(fontSize: 20,),),
                                      )
                                   
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                // ignore: unnecessary_null_comparison
                itemCount: _chat == null ? 0 :_chat.length,
              );
            } else{
              return Center(child: Text("${data.error}"));
            }
          },
        ));
  }
}
