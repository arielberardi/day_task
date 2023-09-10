import 'package:flutter/material.dart';
import 'package:day_task/models/member_model.dart';

class AvatarMembersList extends StatelessWidget {
  final List<Member> members;

  const AvatarMembersList({
    super.key,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 20,
        child: Stack(
          children: List.generate(
            members.length > 5 ? 5 : members.length,
            (index) {
              return Positioned(
                right: 10.0 * index,
                top: 1.5,
                child: CircleAvatar(
                  radius: 7.5,
                  backgroundImage: NetworkImage(members[index].avatarUrl),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
