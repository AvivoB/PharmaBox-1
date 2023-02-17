// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'experiences_bloc.dart';

@immutable
abstract class ExperiencesEvent {}

class InitialiseExperience extends ExperiencesEvent {
   List<Experience> _experiences;

  InitialiseExperience({
    required List<Experience> experiences,
  }) : _experiences = experiences;
}

class AddLocalExperience extends ExperiencesEvent {
   Experience _experience;
  AddLocalExperience({
    required Experience experience,
  }) : _experience = experience;
}

class RemoveLocalExperience extends ExperiencesEvent {
   Experience _experience;
  RemoveLocalExperience({
    required Experience experience,
  }) : _experience = experience;
}

class AddRemoteExperience extends ExperiencesEvent {
   Experience _experience;
  AddRemoteExperience({
    required Experience experience,
  }) : _experience = experience;
}

class RemoveRemoteExperience extends ExperiencesEvent {
   Experience _experience;
  RemoveRemoteExperience({
    required Experience experience,
  }) : _experience = experience;
}

class UpdateExperience extends ExperiencesEvent {
   Experience _experience;
  UpdateExperience({
    required Experience experience,
  }) : _experience = experience;
}
class Init extends ExperiencesEvent{}