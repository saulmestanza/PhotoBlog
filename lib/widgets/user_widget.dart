import 'package:flutter/material.dart';
import 'package:photo_blog/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UserWidget extends StatelessWidget {
  final UserModel user;
  const UserWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Username: ${user.username}",
            ),
            Row(
              children: [
                Text(user.phone),
                const Icon(
                  Icons.call,
                  size: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  color: Colors.redAccent,
                  onPressed: () {
                    openMap(user.address.geo.lat, user.address.geo.lng);
                  },
                  icon: const Icon(Icons.location_pin),
                ),
                IconButton(
                  color: Colors.black,
                  onPressed: () {
                    sendEmail(user.email);
                  },
                  icon: const Icon(Icons.email),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void openMap(String latitude, String longitude) async {
    final mapUri =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    if (await canLaunchUrl(Uri.parse(mapUri))) {
      await launchUrl(Uri.parse(mapUri));
    } else {
      throw 'Could not launch $mapUri';
    }
  }

  void sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }
}
