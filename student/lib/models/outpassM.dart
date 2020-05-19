class Outpass {
  final String outpassID;
  final String location;
  final String reqDateTime;
  final String depDateTime;
  final String arrDateTime;
  String outpassStatus = 'Pending';

  Outpass({
    this.outpassID,
    this.location,
    this.reqDateTime,
    this.depDateTime,
    this.arrDateTime,
    this.outpassStatus,
  });

}
