class BringMovieTranscriptDto {
  List<BringTranscriptDto> transcript;

  BringMovieTranscriptDto({required this.transcript});

  BringMovieTranscriptDto.fromJson(Map<String, dynamic> json)
      : transcript = (json['transcript'] as List)
            .map((e) => BringTranscriptDto.fromJson(e))
            .toList();
}


class BringTranscriptDto {
  int id;
  bool isSuccess;
  String speechToText;
  String emotion;
  int movieScenarioSentenceId;
  CorrectionProposal correctionProposal;

  BringTranscriptDto(this.id, this.isSuccess, this.emotion, this.speechToText,
      this.movieScenarioSentenceId, this.correctionProposal);

  BringTranscriptDto.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isSuccess = json['is_success'],
        speechToText = json['speech_to_text'],
        emotion = json['emotion'],
        correctionProposal =
            CorrectionProposal.fromJson(json['correction_proposal']),
        movieScenarioSentenceId = json['movie_scenario_sentence_id'];
}

class CorrectionProposal {
  int id;
  String proposal;

  CorrectionProposal(this.id, this.proposal);

  CorrectionProposal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        proposal = json['proposal'];
}
