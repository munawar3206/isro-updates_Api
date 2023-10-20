import 'dart:convert';

List<Space> spaceListFromJson(String str) => List<Space>.from(json.decode(str).map((x) => Space.fromJson(x)));

String spaceListToJson(List<Space> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Space {
    String uuid;
    String name;
    String serialNumber;
    DateTime launchDate;
    String launchType;
    String payload;
    String link;
    MissionStatus missionStatus;

    Space({
        required this.uuid,
        required this.name,
        required this.serialNumber,
        required this.launchDate,
        required this.launchType,
        required this.payload,
        required this.link,
        required this.missionStatus,
    });

    factory Space.fromJson(Map<String, dynamic> json) => Space(
        uuid: json["UUID"],
        name: json["Name"],
        serialNumber: json["SerialNumber"],
        launchDate: DateTime.parse(json["LaunchDate"]),
        launchType: json["LaunchType"],
        payload: json["Payload"],
        link: json["Link"],
        missionStatus: missionStatusValues.map[json["MissionStatus"].toLowerCase()] ?? MissionStatus.MISSION_UNSUCCESSFUL,
    );

    Map<String, dynamic> toJson() => {
        "UUID": uuid,
        "Name": name,
        "SerialNumber": serialNumber,
        "LaunchDate": "${launchDate.toIso8601String()}",
        "LaunchType": launchType,
        "Payload": payload,
        "Link": link,
        "MissionStatus": missionStatusValues.reverse[missionStatus],
    };
}

enum MissionStatus {
    missionSuccessful,
    missionUnsuccessful, MISSION_UNSUCCESSFUL
}

final missionStatusValues = EnumValues({
    "mission successful": MissionStatus.missionSuccessful,
    "mission unsuccessful": MissionStatus.missionUnsuccessful
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
