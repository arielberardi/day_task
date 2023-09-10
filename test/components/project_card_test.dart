import 'package:day_task/components/project_card.dart';
import 'package:day_task/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_task/models/member_model.dart';
import 'package:day_task/models/task_model.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  final Project projectSample = Project(
    id: '1',
    name: 'Example Project',
    progress: 45,
    dueOn: DateTime.now(),
    members: [
      Member(
        id: '1',
        fullName: 'Test Example',
        email: 'test@example.com',
        avatarUrl: 'https://ui-avatars.com/api/?rounded=true&background=random',
      )
    ],
    tasks: [
      Task(
        id: '1',
        name: 'Example Task',
        progress: 100,
        members: [
          Member(
            id: '2',
            fullName: 'Test Example',
            email: 'test@example.com',
            avatarUrl:
                'https://ui-avatars.com/api/?rounded=true&background=random',
          )
        ],
      )
    ],
  );

  group('ProjectCard', () {
    testWidgets('shows title members progress', (WidgetTester tester) async {
      mockNetworkImagesFor(() async {
        await tester.pumpWidget(
          MaterialApp(
              home: Scaffold(
            body: SizedBox(
              width: 1000,
              height: 1000,
              child: ProjectCard(projectSample),
            ),
          )),
        );

        final title = find.text(projectSample.name);
        final dueOn = find.text(
          'components.projectCard.dueOn ${projectSample.dueOn}',
        );

        expect(title, findsOneWidget);
        expect(dueOn, findsOneWidget);
        expect(find.byType(CircularPercentIndicator), findsOneWidget);
        expect(find.byType(CircleAvatar), findsWidgets);
      });
    });
  });
}
