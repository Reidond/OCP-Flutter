class UserBody {
  final int id;
  final String email;
  final String provider;
  final String uid;
  final bool allowPasswordChange;
  final belongTo;
  final bool isAdmin;
  final bool isExecutor;
  final bool isSecretary;

  UserBody(
      {this.email,
      this.id,
      this.provider,
      this.uid,
      this.allowPasswordChange,
      this.belongTo,
      this.isAdmin,
      this.isExecutor,
      this.isSecretary});

  factory UserBody.fromJson(Map<String, dynamic> json) {
    return UserBody(
        id: json['data']['id'],
        email: json['data']['email'],
        provider: json['data']['provider'],
        uid: json['data']['uid'],
        allowPasswordChange: json['data']['allow_password_change'],
        belongTo: json['data']['belong_to'],
        isAdmin: json['data']['is_admin'],
        isExecutor: json['data']['is_executor'],
        isSecretary: json['data']['is_secretary']);
  }

  Map toMap() {
    var map = new Map<String, String>();
    map["id"] = id.toString();
    map["email"] = email;
    map["provider"] = provider;
    map["uid"] = uid;
    map["allowPasswordChange"] = allowPasswordChange.toString();
    map["belongTo"] = belongTo;
    map["isAdmin"] = isAdmin.toString();
    map["isExecutor"] = isExecutor.toString();
    map["isSecretary"] = isSecretary.toString();

    return map;
  }
}
