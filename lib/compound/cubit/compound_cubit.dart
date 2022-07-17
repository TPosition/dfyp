import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:compounds_repository/compounds_repository.dart';
import 'package:formz/formz.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'compound_state.dart';

class CompoundCubit extends Cubit<CompoundState> {
  CompoundCubit(
      {required final List<Compound> compounds,
      required final Razorpay razorpay})
      : _compounds = compounds,
        _razorpay = razorpay,
        super(
          CompoundState(
            selectedCompound: Compound(
              uid: 'uid',
              amount: 0,
              reason: 'reason',
              agency: 'agency',
              plate: 'plate',
              isPaid: false,
            ),
          ),
        );

  final List<Compound> _compounds;
  final Razorpay _razorpay;

  void init() {
    emit(state.copyWith(compoundsList: _compounds));

    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError)
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void selectedCompoundChanged(final Compound value) {
    emit(
      state.copyWith(
        selectedCompound: value,
      ),
    );
  }

  Future<void> payCompound(
    final String uid,
    final String email,
    final String displayName,
    final String mobile,
    final num amount,
  ) async {
    try {
      final options = {
        'key': 'rzp_test_HrKYY6mdiMRJLt',
        'amount':
            (double.parse(amount.toString()) * 100.roundToDouble()).toString(),
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
