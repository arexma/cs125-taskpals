import "package:health/health.dart";

const dataTypesIos = [
  HealthDataType.STEPS,
  HealthDataType.MINDFULNESS,
  HealthDataType.WATER,
  HealthDataType.SLEEP_ASLEEP,
];
const permissions = [HealthDataAccess.READ];
final currentDate = DateTime.now();
final midNight = DateTime(currentDate.year, currentDate.month, currentDate.day);
