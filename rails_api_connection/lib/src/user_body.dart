class UserBody {
  final int id;
  final String email;
  final String provider;
  final String uid;
  final bool allowPasswordChange;
  final String belongTo;
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
        id: json['id'],
        email: json['email'],
        provider: json['provider'],
        uid: json['uid'],
        allowPasswordChange: json['allow_password_change'],
        belongTo: json['belong_to'],
        isAdmin: json['is_admin'],
        isExecutor: json['is_executor'],
        isSecretary: json['is_secretary']);
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
