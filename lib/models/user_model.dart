// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                  ┃
// ┃                                    UserModel                                     ┃
// ┃                                                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class ModuUser {
  ModuUser({
    required this.id,                     // 고유 아이디
    required this.name,                   // 이름
    required this.gender,                 // 성별
    required this.birthDay,               // 생일
    required this.image,                  // 프로필 이미지
    required this.createdAt,              // 계정 생성일
    required this.email,                  // 이메일
    required this.pushToken,              // 푸시 알림용 토큰
    required this.partnerId,              // 파트너 아이디
  });

  late String id;
  late String name;
  late String gender;
  late String birthDay;
  late String image;
  late String createdAt;
  late String email;
  late String pushToken;
  late String partnerId;

  ModuUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    gender = json['gender'] ?? '';
    birthDay = json['birth_day'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    id = json['id'] ?? '';
    email = json['email'] ?? '';
    pushToken = json['push_token'] ?? '';
    partnerId = json['partner_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['gender'] = gender;
    data['birth_day'] = birthDay;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['email'] = email;
    data['push_token'] = pushToken;
    data['partner_id'] = partnerId;
    return data;
  }
}
