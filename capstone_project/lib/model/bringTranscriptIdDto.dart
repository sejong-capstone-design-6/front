class BringTranscriptIdDto {
  int transcriptId;

  BringTranscriptIdDto({required this.transcriptId});

  BringTranscriptIdDto.fromJson(Map<String, dynamic> json) :
    transcriptId = json['transcriptId'];
}