class Request {
  String date;
  String imageUrl;
  String mealType;
  String ngoName;
  String address;
  String contact;
  int mealsRequired;
  bool? isFulFilled;
  int remaining;
  String id;

  Request(
      {required this.date,
      required this.mealType,
      required this.mealsRequired,
      this.ngoName = '',
      this.address = '',
      this.contact = '',
      this.imageUrl = '',
      this.id = '',
      this.remaining = 0,
      this.isFulFilled = false});
}

final List<Request> requests = [];
