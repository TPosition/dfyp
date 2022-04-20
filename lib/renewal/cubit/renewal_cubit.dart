import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:licenses_repository/licenses_repository.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'renewal_state.dart';

class RenewalCubit extends Cubit<RenewalState> {
  RenewalCubit(
    this._licensesRepository,
    this._razorpay,
    this._licenses,
  ) : super(
          RenewalState(
            lid: License(
              department: '',
              expiry: DateTime.now(),
              lclass: '',
              period: 0,
              status: 'pending',
              type: '',
              uid: '',
            ),
          ),
        );

  final FirebaseLicensesRepository _licensesRepository;
  final Razorpay _razorpay;
  final List<License> _licenses;

  void init() {
    emit(state.copyWith(lid: _licenses[0], licensesList: _licenses));

    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void lidChanged(final License value) {
    emit(
      state.copyWith(
        lid: value,
      ),
    );
  }

  void periodChanged(final int value) {
    emit(
      state.copyWith(
        period: value,
      ),
    );
  }

  Future<void> renewalFormSubmitted(
    final String uid,
    final String email,
    final String displayName,
    final String mobile,
    final License license,
  ) async {
    try {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        final options = {
          'key': 'rzp_test_HrKYY6mdiMRJLt',
          'amount':
              (double.parse(state.amount.toString()) * 100.roundToDouble())
                  .toString(),
          'name': displayName,
          'description': 'Top up wallet',
          'prefill': {'contact': mobile, 'email': email},
          'external': {
            'wallets': [''],
          },
          'currency': 'MYR'
        };

        _razorpay.open(options);
      } on Exception catch (e) {
        throw Exception(e);
      }

      if (state.status == FormzStatus.submissionSuccess) {
        await _licensesRepository.updateLicense(
          license.copyWith(
            expiry: DateTime.now().add(Duration(days: state.period * 365)),
            period: license.period + state.period,
          ),
        );
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void _handlePaymentSuccess(final PaymentSuccessResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionSuccess,
      ),
    );
  }

  void _handlePaymentError(final PaymentFailureResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionFailure,
      ),
    );
  }

  void _handleExternalWallet(final ExternalWalletResponse response) {
    emit(
      state.copyWith(
        status: FormzStatus.submissionFailure,
      ),
    );
  }
}
