import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  CollectionReference messages = FirebaseFirestore.instance.collection(
    KMessagesCollection,
  );

  TextEditingController controller = TextEditingController();

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)?.settings.arguments;

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];
          messagesList = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return MessageModel.fromJson(data);
          }).toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: PrimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,

                    itemBuilder: (context, index) {
                      return messagesList[index].senderEmail == email
                          ? ChatBubbleRight(message: messagesList[index])
                          : ChatBubble(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,

                    onSubmitted: (value) {
                      messages.add({
                        'message': value,
                        'createdAt': DateTime.now(),
                        'senderEmail': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      );
                    },

                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.send, color: PrimaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: PrimaryColor),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: PrimaryColor),
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('Loading...', style: TextStyle(color: PrimaryColor));
        }
      },
    );
  }
}
