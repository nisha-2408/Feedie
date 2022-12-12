class HungerSpotData {
  final List<String> images;
  final String hungerSpotName;
  final String address;
  final int population;
  final bool isApproved = false;
  HungerSpotData(
      {required this.images,
      required this.address,
      required this.population,
      required this.hungerSpotName});
}
