import 'package:flutter/material.dart';
import 'package:personal_website/i18n.dart';
import 'package:personal_website/widgets/clip_bdrs.dart';

class NameCard extends StatelessWidget {
  const NameCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipBDRS(
              topLeftX: 0.3,
              topRightX: 0.7,
              bottomRightX: 0.63,
              bottomLeftX: 0.37,
              topLeftY: 0.3,
              topRightY: 0.3,
              bottomRightY: 0.7,
              bottomLeftY: 0.7,
              child: Image.asset(
                'assets/images/profile/profile.png',
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
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
