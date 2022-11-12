const IS_DARK = 'isDark';
const IS_FIRST_TIME = 'isFirstTime';
const USER_TOKEN = "token";

void log(String message) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(message).forEach((match) => print(match.group(0)));
}
