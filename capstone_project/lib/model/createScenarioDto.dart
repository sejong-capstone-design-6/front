class CreateScenarioDto {
  int scenarioID;
  String text;
  String emotion;

  CreateScenarioDto(this.scenarioID, this.text,this.emotion);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['scenarioId'] = scenarioID;
    data['text'] = text;
    data['emotion'] = emotion;

    return data;
  }
}
