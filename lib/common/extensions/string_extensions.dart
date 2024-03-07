extension StringExtension on String {
  String removeAssetsImagesPath() {
    return replaceAll('assets/images/', '');
  }

  String removeAssetsAudioPath() {
    return replaceAll('assets/audio/', '');
  }
}
