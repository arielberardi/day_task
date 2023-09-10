import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_task/components/task_card.dart';
import 'package:day_task/components/team_members_list.dart';
import 'package:day_task/models/member_model.dart';
import 'package:day_task/models/task_model.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  final Task taskSample = Task(
    id: '1',
    name: 'Example Task',
    progress: 45,
    members: [
      Member(
        id: '1',
        fullName: 'Test Example',
        email: 'test@example.com',
        avatarUrl: 'https://ui-avatars.com/api/?rounded=true&background=random',
      )
    ],
  );

  final Task taskCompletedSample = Task(
    id: '2',
    name: 'Example Task',
    progress: 100,
    members: [
      Member(
        id: '2',
        fullName: 'Test Example',
        email: 'test@example.com',
        avatarUrl: 'https://ui-avatars.com/api/?rounded=true&background=random',
      )
    ],
  );

  group('TaskCard', () {
    testWidgets('shows title progress members', (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
            body: SizedBox(
              width: 500,
              height: 500,
              child: TaskCard(taskSample),
            ),
          )),
        );

        final title = find.text(taskSample.name);
        final progress =
            find.text('${taskSample.progress.toStringAsFixed(0)}%');
        final inProgress = find.text('components.taskCard.progress');

        expect(title, findsOneWidget);
        expect(progress, findsOneWidget);
        expect(inProgress, findsOneWidget);
        expect(find.byType(AvatarMembersList), findsOneWidget);
      });
    });

    testWidgets('shows task as completed', (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
            body: SizedBox(
              width: 1000,
              height: 1000,
              child: TaskCard(taskCompletedSample),
            ),
          )),
        );

        final completed = find.text('components.taskCard.completed');
        expect(completed, findsOneWidget);
      });
    });
  });
}
