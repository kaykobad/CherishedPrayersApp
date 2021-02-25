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
  String lastMessage;

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
}