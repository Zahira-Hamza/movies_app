class UserProfile {
  final String? email;
  final int? avatarId;
  final String? name;
  final String? phone;

  UserProfile({this.email, this.avatarId, this.name, this.phone});

  Map<String, dynamic> toJson() {
    return {
      if (email != null) "email": email,
      if (avatarId != null) "avatarId": avatarId,
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
    };
  }
}
