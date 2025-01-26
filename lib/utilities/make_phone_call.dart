import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void makePhoneCall(
    {required String phoneNumber, required BuildContext context}) async {
  final Uri phoneUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );

  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Could not launch the dialer')),
    );
  }
}
