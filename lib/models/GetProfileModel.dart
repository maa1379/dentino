

class GetProfileModel {
  GetProfileModel({
    this.name,
    this.family,
    this.nationalCode,
    this.isDone,
    this.inviteCode,
    this.referralCode,
    this.invitedUserCount,
    this.userScore,
  });

  String name;
  String family;
  String nationalCode;
  bool isDone;
  dynamic inviteCode;
  String referralCode;
  int invitedUserCount;
  int userScore;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    name: json["name"],
    family: json["family"],
    nationalCode: json["national_code"],
    isDone: json["is_done"],
    inviteCode: json["invite_code"],
    referralCode: json["referral_code"],
    invitedUserCount: json["invited_user_count"],
    userScore: json["user_score"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "family": family,
    "national_code": nationalCode,
    "is_done": isDone,
    "invite_code": inviteCode,
    "referral_code": referralCode,
    "invited_user_count": invitedUserCount,
    "user_score": userScore,
  };
}
