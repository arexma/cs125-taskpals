import "package:health/health.dart";

import "../../main.dart";
import "./constants.dart";

class HealthService {
  Future<int?> getSteps() async {
    // Request Authorization
    final bool requested = await healthFactory
        .requestAuthorization([dataTypesIos[0]], permissions: permissions);
    if (requested) {
      return healthFactory.getTotalStepsInInterval(midNight, currentDate);
    }
    return -1;
  }

  // data -> {1: HEIGHT, 2: WEIGHT}
  Future<List<HealthDataPoint>> getWeightAndHeight(int data) async {
    var now = DateTime.now();
    final bool requested = await healthFactory
        .requestAuthorization([dataTypesIos[data]], permissions: permissions);
    if (requested) {
      return healthFactory.getHealthDataFromTypes(
          now.subtract(const Duration(days: 1)), now, [dataTypesIos[data]]);
    }
    return [];
  }
}
