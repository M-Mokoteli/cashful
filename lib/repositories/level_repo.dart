import 'package:flutter_application_1/models/level_model.dart';

import '../services/level_service.dart';

class LevelRepository {
  LevelService _levelService;

  LevelRepository(this._levelService);

  Future<List<Level>?> getLevels() async {
    var snapshot = await _levelService.getLevels();
    List<Level> levels = [];
    levels.addAll(snapshot.docs.map((e) => Level.fromFirebase(e)).toList());
    return levels;
  }

  Future<Level?> getLevel(String uid) async {
    var snapshot = await _levelService.getLevel(uid);
    return Level.fromFirebase(snapshot);
  }
}
