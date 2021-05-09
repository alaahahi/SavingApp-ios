import 'package:easy_localization/easy_localization.dart';

String fixPhotoUrl({
  String url,
  String preffix = 'http://savingapp.co/AdminCp/storage/app/public/',
}) {
  if (url == null) url = " ";
  String trimedUrl = url.toLowerCase().trim();
  if (trimedUrl.startsWith('http://') || trimedUrl.startsWith('https://'))
    return url;
  if (trimedUrl.isEmpty) return 'NoImagePlaceHolder'.tr();
  return preffix + url;
}
