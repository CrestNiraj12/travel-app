import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traveller/main.dart';

final reviewServiceProvider =
    Provider<ReviewService>((ref) => ReviewService(ref));

abstract class IReviewService {
  void submitReview(Map<String, dynamic> data);
}

class ReviewService extends IReviewService {
  ReviewService(this.ref);
  final Ref ref;

  @override
  Future<void> submitReview(Map<String, dynamic> data) async {
    await ref.read(httpClientProvider).post("/review", data: data);
  }
}
