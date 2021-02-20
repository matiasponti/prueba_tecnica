import 'dart:convert';


class ListCreators {
  List<Creator> items = new List();
  ListCreators();

  ListCreators.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item in jsonList) {
      final creator = new Creator.fromJson(item);
      items.add(creator);
    }
  }
}

Creator creatorFromJson(String str) => Creator.fromJson(json.decode(str));

String creatorToJson(Creator data) => json.encode(data.toJson());

class Creator {
  Creator({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.fullName,
    this.modified,
    this.thumbnail,
    this.resourceUri,
    this.comics,
    this.series,
    this.stories,
    this.events,
    this.urls,
  });

  int id;
  String firstName;
  String middleName;
  String lastName;
  String suffix;
  String fullName;
  String modified;
  Thumbnail thumbnail;
  String resourceUri;
  Comics comics;
  Comics series;
  Stories stories;
  Comics events;
  List<Url> urls;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json["id"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    suffix: json["suffix"],
    fullName: json["fullName"],
    modified: json["modified"],
    thumbnail: Thumbnail.fromJson(json["thumbnail"]),
    resourceUri: json["resourceURI"],
    comics: Comics.fromJson(json["comics"]),
    series: Comics.fromJson(json["series"]),
    stories: Stories.fromJson(json["stories"]),
    events: Comics.fromJson(json["events"]),
    urls: List<Url>.from(json["urls"].map((x) => Url.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "suffix": suffix,
    "fullName": fullName,
    "modified": modified,
    "thumbnail": thumbnail.toJson(),
    "resourceURI": resourceUri,
    "comics": comics.toJson(),
    "series": series.toJson(),
    "stories": stories.toJson(),
    "events": events.toJson(),
    "urls": List<dynamic>.from(urls.map((x) => x.toJson())),
  };
}

class Comics {
  Comics({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int available;
  String collectionUri;
  List<ComicsItem> items;
  int returned;

  factory Comics.fromJson(Map<String, dynamic> json) => Comics(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<ComicsItem>.from(json["items"].map((x) => ComicsItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class ComicsItem {
  ComicsItem({
    this.resourceUri,
    this.name,
  });

  String resourceUri;
  String name;

  factory ComicsItem.fromJson(Map<String, dynamic> json) => ComicsItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
  };
}

class Stories {
  Stories({
    this.available,
    this.collectionUri,
    this.items,
    this.returned,
  });

  int available;
  String collectionUri;
  List<StoriesItem> items;
  int returned;

  factory Stories.fromJson(Map<String, dynamic> json) => Stories(
    available: json["available"],
    collectionUri: json["collectionURI"],
    items: List<StoriesItem>.from(json["items"].map((x) => StoriesItem.fromJson(x))),
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "collectionURI": collectionUri,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "returned": returned,
  };
}

class StoriesItem {
  StoriesItem({
    this.resourceUri,
    this.name,
    this.type,
  });

  String resourceUri;
  String name;
  Type type;

  factory StoriesItem.fromJson(Map<String, dynamic> json) => StoriesItem(
    resourceUri: json["resourceURI"],
    name: json["name"],
    type: typeValues.map[json["type"]],
  );

  Map<String, dynamic> toJson() => {
    "resourceURI": resourceUri,
    "name": name,
    "type": typeValues.reverse[type],
  };
}

enum Type { INTERIOR_STORY }

final typeValues = EnumValues({
  "interiorStory": Type.INTERIOR_STORY
});

class Thumbnail {
  Thumbnail({
    this.path,
    this.extension,
  });

  String path;
  String extension;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    path: json["path"],
    extension: json["extension"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "extension": extension,
  };
}

class Url {
  Url({
    this.type,
    this.url,
  });

  String type;
  String url;

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "url": url,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
