class DiagnoseQuestion {
  final String question;
  final List<String> answers;

  DiagnoseQuestion(this.question, this.answers);
}

List<DiagnoseQuestion> questions = [
  DiagnoseQuestion('When was the last time you added fuel to your car?', [
    'less than 3 days',
    'more than 3 days',
  ]),
  DiagnoseQuestion(
      'Did you drive long distances since last time  you added fuel?', [
    'Yes',
    'No',
  ]),
  DiagnoseQuestion('Does the fuel indicator change? ', [
    'Yes',
    'No',
    'I don’t know',
  ]),
];
