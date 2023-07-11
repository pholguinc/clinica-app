import 'package:flutter/material.dart';
import '../models/account.dart';
import '../widgets/account_title.dart';
import '../widgets/avatar_card.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AvatarCard(),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 10),
                Column(
                  children: List.generate(accounts.length,
                      (index) => AccountTitle(account: accounts[index])),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
