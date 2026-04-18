class UserFormData {
  int? gender; // 0 Male, 1 Female
  int? age;
  String job = "Dokter";
  double sleepDuration = 6.5;
  int sleepQuality = 7;
  int stressLevel = 7;
  String activityLevel = "Sedentary";
  int heightCm = 165;
  int weightKg = 60;
  int steps = 7000;

  double get bmi {
    if (heightCm == 0 || weightKg == 0) return 0;
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
  
  String get bmiCategory {
    double b = bmi;
    if (b < 18.5) return "Kurus";
    if (b < 24.9) return "Normal";
    if (b < 29.9) return "Overweight";
    return "Obese";
  }
}

enum Activity { sedentary, light, active }