// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarketContractEntity {
  final int id;
  final int serviceProductId;
  final double price;
  final int marketId;
  final bool isActive;
  final String? marketName;

   MarketContractEntity(
      {required this.id,
      required this.serviceProductId,
      required this.price,
      required this.marketId,
      required this.isActive,
      this.marketName});


}
