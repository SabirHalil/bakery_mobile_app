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
