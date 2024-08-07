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
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Colors.black54, style: BorderStyle.none)),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text('Policy',
            style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              const Text(
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
                "\n\n",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
