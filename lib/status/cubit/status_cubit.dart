import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:licenses_repository/licenses_repository.dart';

part 'status_state.dart';

class StatusCubit extends Cubit<StatusState> {
  StatusCubit(
      {required final List<License> licenses, required final String uid})
      : _licenses = licenses,
        _uid = uid,
        super(const StatusState());

  final List<License> _licenses;
  final String _uid;

  void init() {
    emit(state.copyWith(licensesList: _licenses));

    // sort by status
    if (_licenses.isNotEmpty) {
      List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();

      //remove null
      filtered = filtered.whereType<License>().toList();
      filtered.sort((final a, final b) => a!.status.compareTo(b!.status));
      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
  }

  void searchChanged(final int value) {
    // sort by status
    if (value == 1) {
      List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();

      filtered.sort((final a, final b) => a!.status.compareTo(b!.status));
      filtered = filtered.whereType<License>().toList();

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }

    // sort by timestamp
    if (value == 2) {
      List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered.sort((final a, final b) => a!.timestamp.compareTo(b!.timestamp));
      filtered = filtered.whereType<License>().toList();

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
    // sort by id
    if (value == 3) {
      final List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered.sort((final a, final b) => a!.id.compareTo(b!.id));

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
    // sort by expiry date
    if (value == 4) {
      final List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered.sort((final a, final b) => a!.expiry.compareTo(b!.expiry));

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
    // sort by type
    if (value == 5) {
      final List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered.sort((final a, final b) => a!.type.compareTo(b!.type));

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
    // sort by lcass
    if (value == 6) {
      final List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered.sort((final a, final b) => a!.lclass.compareTo(b!.lclass));

      if (filtered != null) {
        List<License> NonEmptyFiltered(List<License?> filtered) =>
            List.from(filtered);
        emit(state.copyWith(licensesList: NonEmptyFiltered(filtered)));
      }
    }
    // sort by department
    if (value == 7) {
      final List<License?> filtered = state.licensesList.map((final license) {
        if (license.uid == _uid) {
          return license;
        }
        return null;
      }).toList();
      filtered
          .sort((final a, final b) => a!.department.compareTo(b!.department));

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
