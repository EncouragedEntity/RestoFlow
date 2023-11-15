class Table {
  String id;
  String name;
  String statusId;
  int numOfSeats;
  int restaurantId;

  Table({
    required this.id,
    required this.name,
    required this.statusId,
    required this.numOfSeats,
    required this.restaurantId,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    return Table(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      statusId: json['statusId'] ?? "",
      numOfSeats: json['numOfSeats'] ?? 0,
      restaurantId: json['restaurantId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'statusId': statusId,
      'numOfSeats': numOfSeats,
      'restaurantId': restaurantId,
    };
  }
}
