import "../../main.dart";
import "./constants.dart";

class HealthService {
  Future<int?> getSteps() async {
    // Request Authorization
    final bool requested = await healthFactory
        .requestAuthorization(dataTypesIos, permissions: permissions);
    if (requested) {
      return healthFactory.getTotalStepsInInterval(midNight, currentDate);
    }
    return -1;
  }
}
