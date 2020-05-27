class Achievements {
  Achievements()
      : this.worldPercentage = 0,
        this.worldTotal = 0,
        this.europePercentage = 0,
        this.europeTotal = 0,
        this.asiaPercentage = 0,
        this.asiaTotal = 0,
        this.northAmericaPercentage = 0,
        this.northAmericaTotal = 0,
        this.southAmericaPercentage = 0,
        this.southAmericaTotal = 0,
        this.africaPercentage = 0,
        this.africaTotal = 0,
        this.australiaPercentage = 0,
        this.australiaTotal = 0,
        this.antarcticaPercentage = 0,
        this.antarcticaTotal = 0;

  Achievements.fromData(achievements)
      : this.worldPercentage = achievements["worldPercentage"] ?? 0,
        this.worldTotal = achievements["worldTotal"] ?? 0,
        this.europePercentage = achievements["europePercentage"] ?? 0,
        this.europeTotal = achievements["europeTotal"] ?? 0,
        this.asiaPercentage = achievements["asiaPercentage"] ?? 0,
        this.asiaTotal = achievements["asiaTotal"] ?? 0,
        this.northAmericaPercentage = achievements["northAmericaPercentage"] ?? 0,
        this.northAmericaTotal = achievements["northAmericaTotal"] ?? 0,
        this.southAmericaPercentage = achievements["southAmericaPercentage"] ?? 0,
        this.southAmericaTotal = achievements["southAmericaTotal"] ?? 0,
        this.africaPercentage = achievements["africaPercentage"] ?? 0,
        this.africaTotal = achievements["africaTotal"] ?? 0,
        this.australiaPercentage = achievements["australiaPercentage"] ?? 0,
        this.australiaTotal = achievements["australiaTotal"] ?? 0,
        this.antarcticaPercentage = achievements["antarcticaPercentage"] ?? 0,
        this.antarcticaTotal = achievements["antarcticaTotal"] ?? 0;

  static final List<String> continents = <String>[
    'World',
    'Europe',
    'Asia',
    'North America',
    'South America',
    'Africa',
    'Australia',
    'Antarctica'
  ];

  final int worldPercentage;
  final int worldTotal;
  final int europePercentage;
  final int europeTotal;
  final int asiaPercentage;
  final int asiaTotal;
  final int northAmericaPercentage;
  final int northAmericaTotal;
  final int southAmericaPercentage;
  final int southAmericaTotal;
  final int africaPercentage;
  final int africaTotal;
  final int australiaPercentage;
  final int australiaTotal;
  final int antarcticaPercentage;
  final int antarcticaTotal;

  List<int> toList() {
    final List<int> percentagesList = <int>[
      this.worldPercentage,
      this.europePercentage,
      this.asiaPercentage,
      this.northAmericaPercentage,
      this.southAmericaPercentage,
      this.africaPercentage,
      this.australiaPercentage,
      this.antarcticaPercentage
    ];
    return percentagesList;
  }
}
