class CounterService {
  static final CounterService counterService = CounterService();

  factory CounterService() {
    return counterService;
  }
}
