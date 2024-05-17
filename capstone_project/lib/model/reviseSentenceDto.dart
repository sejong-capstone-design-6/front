class ReviseSentenceDto{

  int scenarioId;
  String text;
  String emotion;

  ReviseSentenceDto(this.scenarioId, this.text, this.emotion);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['text'] = text;
    data['emotion']=emotion;

    return data;
  }
}
