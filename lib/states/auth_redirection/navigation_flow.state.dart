import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_flow.state.freezed.dart';

@freezed
class NavigationFlowState with _$NavigationFlowState {
  const factory NavigationFlowState.normal() = _NormalAuthFlow;
}
