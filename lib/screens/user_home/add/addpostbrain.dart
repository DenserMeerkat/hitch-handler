import 'dart:io';

// class Location {
//   late String name;
//   late List<String> searchTerms;

//   Location({required String name, required List<String> searchTerms}) {
//     this.name;
//     this.searchTerms;
//   }
// }

class LocationList {
  static List<String> locationsList = [
    "Red Building",
    "Knowledge Park",
    "Manufacturing Dept.",
    "EEE Dept.",
    "CSE Dept.",
    "Manufacturing Dept.",
    "ECE Dept.",
    "Printing Dept.",
    "IT Dept.",
  ];
  static List<String> getSuggestionLocations(String query) {
    List<String> matchList = [];
    locationsList.forEach((element) =>
        matchList.contains(element) ? null : matchList.add(element));
    matchList.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matchList;
  }
}

// class UploadFile {
//   late File imageFile;
//   late int index;

//   UploadFile({required File imageFile, required int index}) {
//     this.imageFile;
//     this.index;
//   }
// }

class UploadFileList {
  static int _lenth = 0;
  static List<File> _uploadFileList = [];

  static String appendFile(File image) {
    if (_lenth < 5) {
      _uploadFileList.add(image);
      _lenth += 1;
      return "Successfully added";
    } else {
      return "Error : Overflow";
    }
  }

  static int currLength() {
    return _lenth;
  }

  static File retrieveFile(int index) {
    return _uploadFileList[index];
  }

  static String deleteFile(int index) {
    if (index >= 0 && index <= 5) {
      _uploadFileList.removeAt(index);
      _lenth -= 1;
      return "Successfully removed";
    } else {
      return "Error in removing";
    }
  }

  static String clearFileList() {
    try {
      _uploadFileList.clear();
      _lenth = 0;
      return "Successfully cleared";
    } on Exception catch (e) {
      return "Error: ran into exception - $e";
    }
  }

  static int searchFileList(File file) {
    return _uploadFileList.indexOf(file);
  }
}
