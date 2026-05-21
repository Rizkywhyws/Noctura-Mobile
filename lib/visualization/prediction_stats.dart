class PredictionStats {
  final GangguanData gangguan;
  final TrenData tren;
  final RankData rank;

  PredictionStats({
    required this.gangguan,
    required this.tren,
    required this.rank,
  });

  factory PredictionStats.fromJson(Map<String, dynamic> json) {
    return PredictionStats(
      gangguan: GangguanData.fromJson(json['gangguan']),
      tren: TrenData.fromJson(json['tren']),
      rank: RankData.fromJson(json['rank']),
    );
  }
}

class GangguanData {
  final List<String> labels;
  final List<int> data;
  final int total;

  GangguanData({
    required this.labels,
    required this.data,
    required this.total,
  });

  factory GangguanData.fromJson(Map<String, dynamic> json) {
    return GangguanData(
      labels: List<String>.from(json['labels']),
      data: List<int>.from(json['data']),
      total: json['total'],
    );
  }
}

class TrenData {
  final List<String> labels;
  final List<int> data;

  TrenData({
    required this.labels,
    required this.data,
  });

  factory TrenData.fromJson(Map<String, dynamic> json) {
    return TrenData(
      labels: List<String>.from(json['labels']),
      data: List<int>.from(json['data']),
    );
  }
}

class RankData {
  final List<RankItem> items;
  final String mostCommon;
  final String mostCommonLabel;

  RankData({
    required this.items,
    required this.mostCommon,
    required this.mostCommonLabel,
  });

  factory RankData.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List)
        .map((e) => RankItem.fromJson(e))
        .toList();
    return RankData(
      items: items,
      mostCommon: json['most_common'],
      mostCommonLabel: json['most_common_label'],
    );
  }
}

class RankItem {
  final String label;
  final int count;
  final double percentage;

  RankItem({
    required this.label,
    required this.count,
    required this.percentage,
  });

  factory RankItem.fromJson(Map<String, dynamic> json) {
    return RankItem(
      label: json['label'],
      count: json['count'],
      percentage: json['percentage'].toDouble(),
    );
  }
}