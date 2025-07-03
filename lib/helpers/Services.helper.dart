import 'package:nifas_silk/constants/DriverServices.dart';
import 'package:nifas_silk/constants/Services.dart';
import 'package:nifas_silk/constants/VehicleServices.dart';

List<Services> getDriverServices(String locale) {
  if (locale == "am") {
    return DriverAmharicService;
  } else if (locale == "es") {
    return DriverEnglishServices;
  } else {
    return DriverAfaanOromooService;
  }
}

List<Services> getVehicleServices(String locale) {
  if (locale == "am") {
    return VehicleAmharicService;
  } else if (locale == "es") {
    return VehicleEnglishServices;
  } else {
    return VehicleAfaanOromooService;
  }
}

Services findServiceByTypeAndIndex(int index, String type, String locale) {
  if (locale == "am") {
    if (type == "driver") {
      return DriverAmharicService[index];
    } else {
      return VehicleAmharicService[index];
    }
  } else if (locale == "es") {
    if (type == "driver") {
      return DriverEnglishServices[index];
    } else {
      return VehicleEnglishServices[index];
    }
  } else {
    if (type == "driver") {
      return DriverAfaanOromooService[index];
    } else {
      return VehicleAfaanOromooService[index];
    }
  }
}
