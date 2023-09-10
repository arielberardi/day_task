import 'package:day_task/models/member_model.dart';
import 'package:day_task/services/db_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final instance = FakeFirebaseFirestore();
  final db = DbService(instance: instance);

  final member = Member(
    id: '1',
    fullName: 'Example Name',
    email: 'test@example.com',
    avatarUrl: 'url',
  );

  group('DbService#createMember', () {
    test("creates a new member doc in the db", () async {
      String returnedId = await db.createMember(member);

      final snapshot = await instance.collection('members').get();
      final docRef = snapshot.docs.last.id;

      expect(snapshot.docs.isEmpty, false);
      expect(returnedId, docRef);
    });
  });

  group('DbService#readMember', () {
    test("reads an existing member doc", () async {
      final docRef = instance.collection('members').doc('2');
      await docRef.set(member.toJson());

      Member readedMember = await db.readMember('2');

      expect(readedMember.email, member.email);
      expect(readedMember.fullName, member.fullName);
      expect(readedMember.avatarUrl, member.avatarUrl);
    });
  });

  group('DbService#updateMember', () {
    test("updates an existing member doc", () async {
      final docRef = instance.collection('members').doc('3');
      await docRef.set(member.toJson());

      final editedMember = Member(
        id: '3',
        email: member.email,
        avatarUrl: member.avatarUrl,
        fullName: 'New Fullname',
      );

      await db.updateMember('3', editedMember);

      final snapshot = await instance.collection('members').doc('3').get();
      expect(snapshot.exists, true);

      Map<String, dynamic> value = snapshot.data()!;
      Member updatedMember = Member.fromJson(value);
      expect(updatedMember.fullName, editedMember.fullName);
    });
  });

  group('DbService#deleteMember', () {
    test("deletes an existing member doc", () async {
      final docRef = instance.collection('members').doc('4');
      await docRef.set(member.toJson());

      await db.deleteMember('4');

      final snapshot = await instance.collection('members').doc('4').get();
      expect(snapshot.exists, false);
    });
  });

  group('DbService#getAllMembers', () {
    test("deletes an existing member doc", () async {
      await instance.collection('members').doc('5').set(member.toJson());
      await instance.collection('members').doc('6').set(member.toJson());

      final collection = await instance.collection('members').get();

      List<Member> members = await db.getAllMembers();

      expect(members.length, collection.docs.length);
    });
  });
}
