// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                                  ┃
// ┃                               CL_COUPLE_REQ MODEL                                ┃
// ┃                                                                                  ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class CoupleReq {
  CoupleReq({
    required this.id,                     // 고유 아이디
    required this.fromId,                 // 요청 보낸 사람 아이디
    required this.loveStartDay,           // 연애 시작일
    required this.creDtm,                 // 요청 보낸 시간
    required this.member,                 // 요청에 포함된 아이디 리스트
  });

  late String id;
  late String fromId;
  late String loveStartDay;
  late String creDtm;
  late List<String> member;

  CoupleReq.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    fromId = json['from_id'] ?? '';
    loveStartDay = json['love_start_day'] ?? '';
    creDtm = json['cre_dtm'] ?? '';
    member = json['member'] != null ? List<String>.from(json['member']) : []; // 리스트 초기화
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['from_id'] = fromId;
    data['love_start_day'] = loveStartDay;
    data['cre_dtm'] = creDtm;
    data['member'] = member;
    return data;
  }
}
