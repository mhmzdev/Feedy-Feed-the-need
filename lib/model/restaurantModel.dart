class Restaurant {
  String name;
  int votes;

  Restaurant({this.name, this.votes});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(name: json['name'], votes: json['votes']);
  }

  toJson() {
    return {
      "name": name,
      "votes": votes,
    };
  }
}
/*
Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: RestaurantController().viewRestaurants(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(snapshot.data[index].name.toString()),
              trailing: Text(snapshot.data[index].votes.toString()),
              onTap: () {
                Restaurant restaurant = Restaurant(name: "New Rest", votes: 2);

                RestaurantController().deleteRestaurant(restaurant);
              },
            );
          },
        );
      },
    );
  }*/