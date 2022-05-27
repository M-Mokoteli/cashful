import 'package:flutter_application_1/models/level_model.dart';
import 'package:flutter_application_1/repositories/level_repo.dart';
import 'package:flutter_application_1/view_models/base_view_model.dart';

class LevelViewModel extends BaseViewModel {
  LevelRepository _levelRepository;
  List<Level> levels = [];

  LevelViewModel(this._levelRepository);

  Future<bool> getLevels() async {
    try {
      setState(ViewState.Busy);
      var result = await _levelRepository.getLevels();
      if (null != result) {
        levels = result;
      }
      setState(ViewState.Idle);

      return true;
    } catch (e) {
      return false;
    }
  }

  Level? getLevel(String levelId) {
    return levels.firstWhere((element) => element.id == levelId, orElse: null);
  }
}
