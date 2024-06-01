class ReviseScenarioDto {
  String text;

  ReviseScenarioDto(this.text);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = text;

    return data;
  }

  ReviseScenarioDto.fromJson(Map<String, dynamic> json) : text = json['text'];
}
