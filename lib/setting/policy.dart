import 'package:flutter/material.dart';

class PolicyPage extends StatefulWidget {
  const PolicyPage({Key? key}) : super(key: key);

  @override
  State<PolicyPage> createState() => _PolicyState();
}

class _PolicyState extends State<PolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            shape: Border(
                bottom:
                    BorderSide(color: Colors.black54, style: BorderStyle.none)),
            backgroundColor: Colors.blueGrey,
            expandedHeight: 240,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Policy',
                  style: TextStyle(color: Colors.white, fontSize: 50)),
              background: ColoredBox(color: Colors.transparent),
              titlePadding: EdgeInsets.all(24),
            ),
            floating: true,
            pinned: true,
          )
        ],
        body: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 24),
                Text(
                  "This Privacy Policy describes how our mobile application, (hereinafter referred to as “the App”), collects, uses, and discloses your information. The App is committed to maintaining robust privacy protections for its users. Our Privacy Policy is designed to help you understand how we collect and use the personal information you decide to share and help you make informed decisions when using the App."
                  "\n\n"
                  "By using or accessing the App, you accept the practices described in this Privacy Policy. If you do not agree to this policy, please do not use the App. We reserve the right to modify this policy from time to time, so please review it frequently. Your continued use of the App signifies your acceptance of our Privacy Policy as modified."
                  "\n\n"
                  "1. Data We Collect"
                  "\n"
                  "Currently, the App does not collect any personal data. The App is designed to store all data related to your food within the device itself and does not have any feature to collect your personal data."
                  "\n\n"
                  "2. Data Storage and Protection"
                  "\n"
                  "Your data is stored on your device and is not accessible by anyone but you, unless the data on your device is shared by you or your device provider."
                  "\n\n"
                  "3. Future Updates"
                  "\n"
                  "In future updates, if there is a feature that allows user data upload for functionalities such as synchronization, we still will not disclose this information to any third party. We will announce the update of our privacy policy when these features are added."
                  "\n\n"
                  "4. Changes to Our Privacy Policy"
                  "\n"
                  "The App reserves the right to change this policy and our Terms of Service at any time. We will notify users of significant changes to our Privacy Policy by sending a notice to the primary email address specified in your account or by placing a prominent notice on our site. Significant changes will go into effect 30 days following such notification. Non-material changes or clarifications will take effect immediately. You should periodically check the Site and this privacy page for updates."
                  "\n\n"
                  "● Contact Us"
                  "\n"
                  "If you have any questions regarding this Privacy Policy or the practices of this Site, please contact us by sending an email to forgerwise@gmail.com"
                  "\n\n"
                  "Last Updated: 2023/07/25",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
