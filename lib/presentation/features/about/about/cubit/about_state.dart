import 'package:equatable/equatable.dart';
import 'package:twinfix/core/configs/app_configs.dart';
import 'package:twinfix/core/enums/load_status.dart';

class AboutState extends Equatable {
  final LoadStatus loadStatus;
  final String version;

  const AboutState({
    this.loadStatus = LoadStatus.initial,
    this.version = AppConfigs.version,
  });

  AboutState copyWith({LoadStatus? loadStatus, String? version}) {
    return AboutState(
      loadStatus: loadStatus ?? this.loadStatus,
      version: version ?? this.version,
    );
  }

  @override
  List<Object?> get props => [loadStatus, version];
}
