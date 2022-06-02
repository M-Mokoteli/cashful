import 'package:collection/collection.dart';
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

  Level getLevel(String levelId) {
    Level? level = levels.firstWhereOrNull((element) => element.id == levelId);
    if (null == level) {
      level = levels.firstWhereOrNull((element) => element.name == "level1");
    }
    if (null != level) {
      return level;
    } else {
      //creating level 1
      level = Level(
          id: 'DNAI5I84fjoBYrWeJCP7',
          name: 'level1',
          interest: 0.2,
          min: 100,
          max: 250,
          repayDates: ["7", "14", "21", "31"]);

      return level;
    }
  }
}
