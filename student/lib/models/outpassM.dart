class Outpass {
  final String outpassID;
  final String regID;
  final String location;
  final String reqDateTime;
  final String depDateTime;
  final String arrDateTime;
  String outpassStatus = 'Pending';

  Outpass({
    this.outpassID,
    this.regID,
    this.location,
    this.reqDateTime,
    this.depDateTime,
    this.arrDateTime,
    this.outpassStatus,
  });

}
