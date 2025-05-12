import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_art/constant/app_colors.dart';
import 'package:smile_art/view/widgets/my_button.dart';
import 'package:smile_art/view/widgets/my_text_widget.dart';
import 'package:smile_art/view/widgets/profile_appbar.dart';

import 'support_chat.dart';


class HelpCenter extends StatefulWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  // Track expanded item
  int? expandedItem;

  // FAQ items
  final List<Map<String, String>> faqItems = [
    {
      'question': 'How do I create an account?',
      'answer': 'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    },
    {
      'question': 'What is this app for?',
      'answer': 'This app helps users access all the information and resources they need in one place. It provides answers to common questions and offers support options.'
    },
    {
      'question': 'How do I update my personal details?',
      'answer': 'To update your personal details, go to Settings > Profile > Edit Profile. From there, you can change your name, email, phone number, and other personal information.'
    },
    {
      'question': 'Why can\'t I access my simulation link?',
      'answer': 'Simulation links might be inaccessible due to expired sessions, permission issues, or temporary system maintenance. Try refreshing, checking your permissions, or contacting support if the issue persists.'
    },
    {
      'question': 'How do I update my personal details?',
      'answer': 'To update your personal details, go to Settings > Profile > Edit Profile. From there, you can change your name, email, phone number, and other personal information.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:profileAppbar("Help Center"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child: Column(
                    children: [
                      // FAQ items
                      ...List.generate(
                        faqItems.length,
                            (index) => _buildFaqItem(index),
                      ),

                      // "Still Stuck?" section
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                           MyText(text: "Still Stuck? Help is a mail away",size:14,weight:FontWeight.w600,),
                            const SizedBox(height: 16),
                           MyButton(onTap: (){
                             Get.to(ChatSupport());
                           }, buttonText: "Send Message")
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(int index) {
    final isExpanded = expandedItem == index;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              if (isExpanded) {
                expandedItem = null;
              } else {
                expandedItem = index;
              }
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            children: [
              // Question row with arrow
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        faqItems[index]['question'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),

              if (isExpanded)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(
                    faqItems[index]['answer'] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: kGreyColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}