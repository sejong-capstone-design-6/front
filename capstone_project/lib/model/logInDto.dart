class LogInDto {
  String email;
  String password;

  LogInDto(this.email, this.password);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['email'] = email;
    data['password'] = password;

    return data;
  }
}