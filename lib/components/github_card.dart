import 'package:flutter/material.dart';
import 'package:github_top_repos/models/github_repo_model.dart';
import 'package:github_top_repos/provider/github_repos_provider.dart';
import 'package:provider/provider.dart';

class GithubCard extends StatelessWidget {
  final GithubRepoModel githubRepoModel;

  const GithubCard({super.key, required this.githubRepoModel});

  @override
  Widget build(BuildContext context) {
    GithubReposProvider reposProvider = Provider.of(context);
    return GestureDetector(
      onTap: () {
        reposProvider.openRepository(githubRepoModel.repoUrl);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xff2c333b),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xff434b55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xff434b55),
                  backgroundImage: NetworkImage(
                    githubRepoModel.userAvatarUrl,
                  ),
                  onBackgroundImageError: (exception, stackTrace) =>
                      const CircleAvatar(
                    backgroundColor: Color(0xff434b55),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      githubRepoModel.userName,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      githubRepoModel.createdAt,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              githubRepoModel.repoName,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              githubRepoModel.repoDescription,
              style: TextStyle(color: Colors.grey.shade400),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_border_sharp,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      githubRepoModel.starCount.toString(),
                      style: TextStyle(color: Colors.grey.shade400),
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.grey.shade400,
                  size: 18,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
