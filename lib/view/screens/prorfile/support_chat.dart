import 'package:flutter/material.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/common_image_widget.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';
import 'package:smile_art/view/widgets/profile_appbar.dart';

import '../../../generated/assets.dart';


class ChatSupport extends StatefulWidget {
  const ChatSupport({super.key});

  @override
  State<ChatSupport> createState() => _ChatSupportState();
}

class Message {
  final String text;
  final bool isUser;
  final String time;

  Message({required this.text, required this.isUser, required this.time});
}

class _ChatSupportState extends State<ChatSupport> {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [
    Message(
      text: "Hi, can you please help me?",
      isUser: true,
      time: "Wednesday 08:49 pm",
    ),
    Message(
      text: "Sure, I am here to assist you",
      isUser: false,
      time: "Wednesday 08:25 pm",
    ),
    Message(
      text: "Hi, can you please help me?",
      isUser: true,
      time: "Wednesday 08:49 pm",
    ),
    Message(
      text: "Sure, I am here to assist you",
      isUser: false,
      time: "Wednesday 08:25 pm",
    ),
    Message(
      text: "Hi, can you please help me?",
      isUser: true,
      time: "Wednesday 08:49 pm",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:kPrimaryColor,
      appBar:profileAppbar("Chat support"),
      body: SafeArea(
        child: Container(
          decoration:BoxDecoration(
            color:kSecondaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  children: [
                    // Admin avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: CommonImageView(
                        imagePath:Assets.imagesSupport,
                      )
                    ),
                    const SizedBox(width: 12),
                    // Admin info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                          ),
                        ),
                        Text(
                          'I\'m Here To Assist You',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:FontWeight.w600,
                            color: kTextColor
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // "Today" divider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: kBorderColor,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: MyText(text: "Today")
                    ),
                    Expanded(
                      child: Divider(
                        color: kBorderColor,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),

              // Chat messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return _buildMessageItem(message);
                  },
                ),
              ),

              // Message input field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:18.0,vertical:18),
                child: Container(
                  padding: const EdgeInsets.symmetric(),
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(30),
                    color:kBorderColor.withOpacity(0.50)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Row(
                      children: [
                        // Emoji button
                        Icon(
                          Icons.sentiment_satisfied_alt_outlined,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        // Text field
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type message here...',
                              hintStyle: TextStyle(color: kGreyColor,fontSize:14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Send button
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: CommonImageView(
                              svgPath:Assets.iconsSendIc,
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageItem(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment:
        message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) _buildAdminAvatar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Time
              Padding(
                padding: EdgeInsets.only(
                  right: message.isUser ? 0 : 8,
                  left: message.isUser ? 8 : 0,
                  bottom: 4,
                ),
                child: Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: kGreyColor
                  ),
                ),
              ),

              // Message bubble
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: message.isUser
                      ? kPrimaryColor
                      : const Color(0xFF27374E),
                  borderRadius: BorderRadius.only(topRight:Radius.circular(8),bottomRight:Radius.circular(8),bottomLeft:Radius.circular(8)),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          if (message.isUser) _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildAdminAvatar() {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0098B5),
        shape: BoxShape.circle,
      ),
      child:CommonImageView(
        imagePath:Assets.imagesSupport,
      )
    );
  }

  Widget _buildUserAvatar() {
    return Stack(
      children: [
        Container(
          width: 40,
          height: 40,
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(Assets.imagesProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}