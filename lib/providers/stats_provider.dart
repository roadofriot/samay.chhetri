import 'package:flutter/material.dart';

/// Stats Provider
/// Manages real-time statistics like downloads and visits
class StatsProvider extends ChangeNotifier {
  // Initial values
  int _cvDownloadCount = 1008;
  int _profileVisitCount = 10000;

  // Getters
  int get cvDownloadCount => _cvDownloadCount;
  int get profileVisitCount => _profileVisitCount;

  /// Increment CV download count
  void incrementCvDownload() {
    _cvDownloadCount++;
    notifyListeners();
  }

  /// Increment profile visit count
  void incrementProfileVisit() {
    _profileVisitCount++;
    notifyListeners();
  }
}
