import 'package:calculator/Chat/api/apis.dart';
import 'package:calculator/Chat/models/chat_user.dart';
import 'package:calculator/Chat/widgets/chat_user_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'profileScreen.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  List<ChatUser> _list = [];
  final List<ChatUser> _searchList = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // For hiding keyboard after clicking on screen
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_isSearching){
            setState(() {
              _isSearching = !_isSearching;
            });
            return Future.value(false);
          }else{
            return Future.value(true);
          }
        },
        child: Scaffold(
          //Appbar
          appBar: AppBar(
            leading: Icon(CupertinoIcons.home),
            title: _isSearching? TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Name, Email, ...",
              ),
              autofocus: true,
              style: TextStyle(fontSize: 16, letterSpacing: 0.6),

              // when search text changes then update search list
              onChanged: (val) {
                // search logic
                _searchList.clear();

                for(var i in _list) {
                  if(i.name.toLowerCase().contains(val.toLowerCase()) || i.email.toLowerCase().contains(val.toLowerCase())) {
                    _searchList.add(i);
                  }
                  setState(() {
                    _searchList;
                  });
                }
              },
            ):Text("Love Chat"),
            actions: [
              IconButton(onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
              }, icon: Icon(_isSearching ? CupertinoIcons.clear_circled_solid : CupertinoIcons.search)),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ProfileScreen(user: APIs.me)),
                  );
                },
                icon: Icon(Icons.more_vert),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                height: 2.3,
                margin: EdgeInsets.only(left: 2, right: 2),
              ),
            ),
          ),

          //floatingActionButton
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 5),
            child: FloatingActionButton(
              onPressed: () async {
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
              },
              child: Icon(Icons.add_comment_rounded),
            ),
          ),

          //body
          body: StreamBuilder(
            stream: APIs.getAllUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                // if data is loading
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

                // if some or all data is loaded then show it
                case ConnectionState.active:
                case ConnectionState.done:
                  final data = snapshot.data?.docs;
                  _list =
                      data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

                  if (_list.isNotEmpty) {
                    return ListView.builder(
                      itemCount: _isSearching? _searchList.length :_list.length,
                      padding: EdgeInsets.only(top: 10),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ChatUserCard(user: _isSearching? _searchList[index]:_list[index]);
                        // return Text('Name: ${list[index]}');
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No Connections Found',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
