import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void actionShare(String url, screenWidth) {
  Share.share(url, sharePositionOrigin: (Platform.isIOS) ? Rect.fromLTWH(0, 0, screenWidth, 300) : null);
}
