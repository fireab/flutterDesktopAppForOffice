import 'package:nifas_silk/constants/DriverServices.dart';
import 'package:nifas_silk/constants/EnviromentalPollutionControl.dart';
import 'package:nifas_silk/constants/ClimateChangeSErvice.dart';
import 'package:nifas_silk/constants/EcosystemBiodiversity.dart';
import 'package:nifas_silk/constants/MeneralResource.dart';
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

List<Services> getEnvironmentalPollutionControlServices(String locale) {
  if (locale == "am") {
    return EnvironmentalPollutionControlAmharicServices;
  } else if (locale == "es") {
    return EnvironmentalPollutionControlEnglishServices;
  } else {
    return EnvironmentalPollutionControlEnglishServices;
  }
}

List<Services> getClimentChangeService(String locale) {
  if (locale == "am") {
    return ClimateChangeAmharicServices;
  } else if (locale == "es") {
    return ClimateChangeEnglishServices;
  } else {
    return ClimateChangeEnglishServices;
  }
}

List<Services> getMineralResourceService(String locale) {
  if (locale == "am") {
    return MineralResourceAmharicServices;
  } else if (locale == "es") {
    return MineralResourceEnglishServices;
  } else {
    return MineralResourceEnglishServices;
  }
}

List<Services> getEcosystemBiodiversityServices(String locale) {
  if (locale == "am") {
    return EcosystemBiodiversityAmharicServices;
  } else if (locale == "es") {
    return EcosystemBiodiversityEnglishServices;
  } else {
    return EcosystemBiodiversityEnglishServices;
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
  print(type);
  if (locale == "am") {
    if (type == "driver") {
      return DriverAmharicService[index];
    } else if (type == "enviromental pollution") {
      return EnvironmentalPollutionControlAmharicServices[index];
    } else if (type == "climate change") {
      return ClimateChangeAmharicServices[index];
    } else if (type == "ecosystem biodiversity") {
      return EcosystemBiodiversityAmharicServices[index];
    } else if (type == "mineral resource") {
      return MineralResourceAmharicServices[index];
    } else {
      return VehicleAmharicService[index];
    }
  } else if (locale == "es") {
    if (type == "driver") {
      return DriverEnglishServices[index];
    } else if (type == "enviromental pollution") {
      return EnvironmentalPollutionControlEnglishServices[index];
    } else if (type == "climate change") {
      return ClimateChangeEnglishServices[index];
    } else if (type == "ecosystem biodiversity") {
      return EcosystemBiodiversityEnglishServices[index];
    } else if (type == "mineral resource") {
      return MineralResourceEnglishServices[index];
    } else {
      return VehicleEnglishServices[index];
    }
  } else {
    if (type == "driver") {
      return DriverAfaanOromooService[index];
    } else if (type == "enviromental pollution") {
      return EnvironmentalPollutionControlEnglishServices[index];
    } else if (type == "climate change") {
      return ClimateChangeEnglishServices[index];
    } else if (type == "ecosystem biodiversity") {
      return EcosystemBiodiversityEnglishServices[index];
    } else if (type == "mineral resource") {
      return MineralResourceEnglishServices[index];
    } else {
      return VehicleAfaanOromooService[index];
    }
  }
}
