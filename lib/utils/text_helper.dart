String textConverter(String text) {
  return text
      .replaceAll('&#x27;', "'")
      .replaceAll('<p>', '\n\n')
      .replaceAll('</p>', '')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('gvfs#x2f;', '')
      .replaceAll('&quot;', '"')
      .replaceAll('<i>', '')
      .replaceAll('</i>', '');
}
