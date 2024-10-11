// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaginationData<T> {
  final num count;
  final String? previous;
  final String? next;
  final T? results;

  PaginationData({
    this.count = 0,
    this.previous,
    this.next,
    this.results,
  });

  factory PaginationData.fromApiResponse(Map<String, dynamic> response, T data) {
    return PaginationData(
      count: num.tryParse(response['count']?.toString() ?? '') ?? 0,
      previous: response['previous'],
      next: response['next'],
      results: data,
    );
  }

  PaginationData<T> copyWith({
    num? count,
    String? previous,
    String? next,
     T? results}) {
    return PaginationData(
      count: count ?? this.count,
      previous: previous ?? this.previous,
      next: next ?? this.next,
      results: results ?? this.results,
    );
  }
}
