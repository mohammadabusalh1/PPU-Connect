import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppu_connect/core/di/injection.dart';
import 'package:ppu_connect/presentation/cubits/profile/profile_cubit.dart';
import 'package:ppu_connect/presentation/pages/profile/public_profile_page.dart';

class TutorDetailPage extends StatelessWidget {
  const TutorDetailPage({super.key, required this.tutorId});

  final String tutorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..load(tutorId),
      child: PublicProfilePage(userId: tutorId),
    );
  }
}
