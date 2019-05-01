class UserHeaders {
  final String uid;
  final String accessToken;
  final String tokenType;
  final String expiry;
  final String client;

  UserHeaders(
      {this.accessToken, this.uid, this.tokenType, this.expiry, this.client});

  factory UserHeaders.fromJson(Map<String, dynamic> json) {
    return UserHeaders(
      accessToken: json['access-token'],
      uid: json['uid'],
      tokenType: json['token-type'],
      expiry: json['expiry'],
      client: json['client'],
    );
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["accessToken"] = accessToken;
    map["uid"] = uid;
    map["tokenType"] = tokenType;
    map["expiry"] = expiry;
    map["client"] = client;

    return map;
  }
}
