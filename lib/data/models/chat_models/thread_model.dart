part of models;

@JsonSerializable()
class Thread {
  String id;
  int firstUserId;
  String firstUserName;
  String firstUserAvatar;
  int firstUserUnseenMessageCount;
  int secondUserId;
  String secondUserName;
  String secondUserAvatar;
  int secondUserUnseenMessageCount;
  @JsonKey(nullable: true)
  String lastMessage;
  @JsonKey(nullable: true)
  int lastUpdateTimeStamp;
  @JsonKey(nullable: true)
  int firstUserDeleteUntil;
  @JsonKey(nullable: true)
  int secondUserDeleteUntil;
  List<int> users;

  Thread(
    this.id,
    this.firstUserId,
    this.firstUserName,
    this.firstUserAvatar,
    this.firstUserUnseenMessageCount,
    this.secondUserId,
    this.secondUserName,
    this.secondUserAvatar,
    this.secondUserUnseenMessageCount,
    this.lastMessage,
    this.lastUpdateTimeStamp,
    this.firstUserDeleteUntil,
    this.secondUserDeleteUntil,
    this.users,
  );

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);

  Map<String, dynamic> toJson() => _$ThreadToJson(this);

  String getReceiverName(int myId) {
    return myId == firstUserId ? this.secondUserName : this.firstUserName;
  }

  String getReceiverAvatar(int myId) {
    return myId == firstUserId ? this.secondUserAvatar : this.firstUserAvatar;
  }

  int getUnseenMessageCount(int myId) {
    return myId == firstUserId ? this.firstUserUnseenMessageCount : this.secondUserUnseenMessageCount;
  }

  DateTime getLocalTime() {
    return DateTime.fromMillisecondsSinceEpoch(this.lastUpdateTimeStamp).toLocal();
  }
}