extension StringExtension on String {
  String removeAssetsPath() {
    return replaceAll('assets/images/', '');
  }
}
