// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaginatedData<T> {
  final num count;
  final String? previous;
  final String? next;
  final T? results;

  PaginatedData({
    this.count = 0,
    this.previous,
    this.next,
    this.results,
  });

  factory PaginatedData.fromApiResponse(Map<String, dynamic> response, T data) {
    return PaginatedData(
      count: num.tryParse(response['count']?.toString() ?? '') ?? 0,
      previous: response['previous'],
      next: response['next'],
      results: data,
    );
  }
}
