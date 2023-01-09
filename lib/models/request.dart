class Request {
  String imageUrl;
  String ngoName;
  String address;
  int mealsRequired;

  Request({
   required this.imageUrl,
   required this.ngoName,
   required this.address,
   required this.mealsRequired,
  });
}

final List<Request> requests = [
  Request(
    imageUrl: 'assets/images/ngo1.png',
    ngoName: 'NGO 1',
    address: '404 Great St',
    mealsRequired: 175,
  ),
  Request(
    imageUrl: 'assets/images/ngo4.png',
    ngoName: 'NGO 2',
    address: '404 Great St',
    mealsRequired: 30,
  ),
  Request(
    imageUrl: 'assets/images/ngo3.png',
    ngoName: 'NGO 3',
    address: '404 Great St',
    mealsRequired: 50,
  ),
];