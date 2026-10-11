

class CounterStorage {
  static final Map<String, int> categoryTimes = {};

  static void saveTime(String category, int seconds) {
    categoryTimes[category] =
        (categoryTimes[category] ?? 0) + seconds;
  }

  static int getTime(String category) {
    return categoryTimes[category] ?? 0;
  }
}
