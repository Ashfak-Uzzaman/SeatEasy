import 'package:url_launcher/url_launcher.dart';

Future<void> launchEmail(String email, String subject, String body) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query:
        'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Could not launch $emailUri';
  }
}
