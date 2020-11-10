class Tasbih {
  int id;
  String name;
  int numberOfDailyGroups;
  int numberOfTasbihPerGroup;
  int numberOfGroupsDoneToday;
  int numberOfLastCountValue;
  int countingSpeed;
  int tOrder;
  bool active = true;

  Tasbih(
      {this.id,
      this.name,
      this.numberOfDailyGroups = 5,
      this.numberOfTasbihPerGroup = 33,
      this.numberOfGroupsDoneToday = 0,
      this.countingSpeed = 500,
      this.numberOfLastCountValue = 0,
      this.tOrder = 0});

  Tasbih.empty() {
    id = 0;
    name = '';
    countingSpeed = 0;
    numberOfDailyGroups = 0;
    numberOfGroupsDoneToday = 0;
    numberOfLastCountValue = 0;
    numberOfTasbihPerGroup = 0;
    tOrder = 0;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'numberOfDailyGroups': numberOfDailyGroups,
      'numberOfTasbihPerGroup': numberOfTasbihPerGroup,
      'numberOfGroupsDoneToday': numberOfGroupsDoneToday,
      'countingSpeed': countingSpeed,
      'numberOfLastCountValue': numberOfLastCountValue,
      'active': active,
      'tOrder': tOrder,
    };
  }

  //Tasbih toObject(Map<String, dynamic> map) {

  static Tasbih toObject(dynamic map) {
    Tasbih tasbih = Tasbih(
        id: map['id'],
        name: map['name'],
        countingSpeed: map['countingSpeed'],
        numberOfDailyGroups: map['numberOfDailyGroups'],
        numberOfGroupsDoneToday: map['numberOfGroupsDoneToday'],
        numberOfTasbihPerGroup: map['numberOfTasbihPerGroup'],
        numberOfLastCountValue: map['numberOfLastCountValue'],
        tOrder: map['tOrder']);

    return tasbih;
  }
}
