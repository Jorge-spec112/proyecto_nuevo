class FormState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  FormState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.errorMessage,
  });

  FormState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return FormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
