import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:licenses_repository/licenses_repository.dart';

part 'compound_state.dart';

class CompoundCubit extends Cubit<CompoundState> {
  CompoundCubit(
      {required final List<License> licenses, required final String uid})
      : _licenses = licenses,
        _uid = uid,
        super(const CompoundState());

  final List<License> _licenses;
  final String _uid;

  void init() {
    emit(state.copyWith(licensesList: _licenses));

    // sort by compound
    if (_licenses.isNotEmpty) {
      List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
    }
  }

  void searchChanged(final int value) {
    // sort by compound
    if (value == 1) {
      List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();

      // filtered.sort((final a, final b) => a!.compound.compareTo(b!.compound));
      filtered = filtered.whereType<License>().toList();

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
  }

  void datePicked(final DateTime picked) {
    final List<License?> filtered = state.licensesList.map((final license) {
      if (license.timestamp.year == picked.year &&
          license.timestamp.month == picked.month &&
          license.timestamp.day == picked.day) {
        return license;
      }
      return null;
    }).toList();

    emit(state.copyWith(filteredLicensesList: filtered));
  }
}
