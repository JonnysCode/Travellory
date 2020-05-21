class Achievements {

  Achievements():
        this.worldPercentage = 0,
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

  Achievements.fromData(achievements):
        this.worldPercentage = achievements["worldPercentage"],
        this.worldTotal = achievements["worldTotal"],
        this.europePercentage = achievements["europePercentage"],
        this.europeTotal = achievements["europeTotal"],
        this.asiaPercentage = achievements["asiaPercentage"],
        this.asiaTotal = achievements["asiaTotal"],
        this.northAmericaPercentage = achievements["northAmericaPercentage"],
        this.northAmericaTotal = achievements["northAmericaTotal"],
        this.southAmericaPercentage = achievements["southAmericaPercentage"],
        this.southAmericaTotal = achievements["southAmericaTotal"],
        this.africaPercentage = achievements["africaPercentage"],
        this.africaTotal = achievements["africaTotal"],
        this.australiaPercentage = achievements["australiaPercentage"],
        this.australiaTotal = achievements["australiaTotal"],
        this.antarcticaPercentage = achievements["antarcticaPercentage"],
        this.antarcticaTotal = achievements["antarcticaTotal"];

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


}
