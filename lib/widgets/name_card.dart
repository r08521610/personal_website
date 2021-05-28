import 'package:flutter/material.dart';
import 'package:personal_website/i18n.dart';

class NameCard extends StatelessWidget {
  const NameCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              'assets/images/profile/profile.png',
              height: 300,
              width: 300,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                S.of(context)!.name,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Text(S.of(context)!.jobTitle),
            Text(S.of(context)!.specialization),
          ],
        ),
      ),
    );
  }
}
