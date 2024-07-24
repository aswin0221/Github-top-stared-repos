import 'package:intl/intl.dart';

class GithubRepoModel {
  final String repoName;
  final String repoDescription;
  final String createdAt;
  final int starCount;
  final String userName;
  final String userAvatarUrl;
  final String repoUrl;

  GithubRepoModel(
      {required this.repoName,
      required this.userName,
      required this.repoDescription,
      required this.starCount,
      required this.createdAt,
      required this.userAvatarUrl,
      required this.repoUrl});

  static GithubRepoModel fromMap(Map repoData) {
    //this will convert the Iso Date format from the repoData in the dd-MM-yyyy format.
    DateTime dateTime = DateTime.parse(repoData["created_at"]);
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    String date = dateFormat.format(dateTime);

    return GithubRepoModel(
        repoName: repoData["name"],
        userName: repoData["owner"]["login"],
        repoDescription: repoData["description"] ?? "",
        starCount: repoData["stargazers_count"],
        userAvatarUrl: repoData["owner"]["avatar_url"],
        createdAt: date,
        repoUrl: repoData["html_url"]);
  }


}
