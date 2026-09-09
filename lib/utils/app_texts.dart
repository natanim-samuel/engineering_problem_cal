class AppTexts {
  static Map<String, Map<String, String>> texts = {
    "en": {
      "history": "Calculation History",
      "recent": "Your recent calculations",
      "monthlyCost": "Monthly Cost",
      "voltage": "Voltage",
      "current": "Current",
      "power": "Power",
      "dailyEnergy": "Daily Energy",
      "monthlyEnergy": "Monthly Energy",
      "noHistory": "No history yet",
      "clearHistory": "Clear History",
      "sort": "Sort",
      "calculator": "Calculator",
      "applianceName": "Appliance Name",
      "applianceHint": "Fan, Heater, Motor",
      "hours": "Hours per Day",
      "rate": "Rate per kWh",
      "calculate": "Calculate",
      "clear": "Clear All",
      "saved": "Calculation saved to history",
    },
    "am": {
      "history": "የሂሳብ ታሪክ",
      "recent": "የቅርብ ጊዜ ሂሳቦች",
      "monthlyCost": "ወርሃዊ ወጪ",
      "voltage": "ቮልቴጅ",
      "current": "አምፒር",
      "power": "ኃይል",
      "dailyEnergy": "የቀን ኃይል",
      "monthlyEnergy": "የወር ኃይል",
      "noHistory": "ምንም ታሪክ የለም",
      "clearHistory": "ታሪክ አጥፋ",
      "sort": "አደርድር",
      "calculator": "ካልኩሌተር",
      "applianceName": "የእቃ ስም",
      "applianceHint": "ፋን፣ ማሞቂያ፣ ሞተር",
      "hours": "በቀን ሰዓት",
      "rate": "የኤሌክትሪክ ዋጋ",
      "calculate": "አስላ",
      "clear": "ሁሉንም አጥፋ",
      "saved": "ሂሳቡ ተቀምጧል",
    }
  };

  static String get(String key, String lang) {
    return texts[lang]?[key] ?? key;
  }
}