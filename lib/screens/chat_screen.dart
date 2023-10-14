import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore=FirebaseFirestore.instance;
 User? LoggedInUser;
class ChatScreen extends StatefulWidget {
  static String id= 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  var messageText;


  @override
  void initState()
  {
    super.initState();
    getCurrentUser();
  }
  getCurrentUser() async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        LoggedInUser = user;
        _firestore.collection('users').doc(LoggedInUser?.uid).update({
          'isOnline': true,
        });
      }
    }
    catch(e)
    {
    print(e);
  }}

  void messageStream() async{
   await for(var snapshot in _firestore.collection('messages').snapshots())
     {
       for(var message in snapshot.docs)
         {
           print(message.data);
         }
     }
  }
  final messageTextController=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Center(child: Text('⚡️Chat')),
        backgroundColor: Color(0xFF0073E6),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
           Expanded(
               child: MessageStream()),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'text':messageText,
                        'sender':LoggedInUser?.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data?.docs;
        List<Widget> messageWidgets= [];
        for(var message in messages!){
          final messageData = message.data() as Map<String, dynamic>;
          final messageText = messageData['text'];
          final messageSender = messageData['sender'];
          final currentUser=LoggedInUser?.email;

          final messageWidget = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser==messageSender,
          );
          messageWidgets.add(messageWidget);
        }
        return Expanded(
          child: ListView(

            children: messageWidgets,
          ),
        );
      },
    );
  }
}
class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text,required this.sender,required this.isMe});
  final String text;
  final String sender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ?CrossAxisAlignment.end:CrossAxisAlignment.start ,
        children: [
          Text(sender,
          style:TextStyle(
            fontSize: 11.0,
          ),
          ),
          Material(
            elevation:5.0,
            borderRadius: isMe? (BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))) :
              BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: Radius.circular(30)),
            color: isMe ?Color(0xFF0073E6): Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              child: Text(text,
                style: TextStyle(
                  color: isMe?Colors.white:Colors.black87,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
