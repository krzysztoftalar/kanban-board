String boardTitleValidator(String title) {
  if (title.isEmpty) {
    return "Board title can't be empty.";
  } else if (title.length > 100) {
    return "Board title can't be over 100 characters.";
  }
  return null;
}

String cardTitleValidator(String title) {
  if (title.isEmpty) {
    return "Card title can't be empty.";
  } else if (title.length > 100) {
    return "Card title can't be over 100 characters.";
  }
  return null;
}
