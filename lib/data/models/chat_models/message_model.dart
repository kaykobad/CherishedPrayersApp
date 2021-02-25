part of models;

@JsonSerializable()
class Message {
  String threadId;
  int senderId;
  String sentDate;
  String message;
  int type;

  Message(
    this.threadId,
    this.senderId,
    this.sentDate,
    this.message,
    this.type,
  );

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}