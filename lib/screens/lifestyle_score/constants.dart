import "package:health/health.dart";

const dataTypesIos = [
  HealthDataType.STEPS,
  HealthDataType.HEIGHT,
  HealthDataType.WEIGHT,
];
const permissions = [HealthDataAccess.READ];
final currentDate = DateTime.now();
final midNight = DateTime(currentDate.year, currentDate.month, currentDate.day);
