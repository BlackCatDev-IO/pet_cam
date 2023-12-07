import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:pet_cam/env.dart';

class AnalyticsService {
  late final Mixpanel _mixpanel;

  Future<void> init() async {
    _mixpanel =
        await Mixpanel.init(Env.mixpanelToken, trackAutomaticEvents: true);
  }

  void track(String eventName, [Map<String, dynamic>? properties]) {
    if (kReleaseMode) {
      _mixpanel.track(eventName, properties: properties);
      log(eventName, name: 'AnalyticsService');
    }
  }
}
