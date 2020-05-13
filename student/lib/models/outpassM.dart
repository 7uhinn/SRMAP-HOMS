enum OutpassStatus {
  Pending,
  Approved,
  Disapproved,
}

class Outpass {
  final String outpassID;
  final String regID;
  final String location;
  final DateTime reqDateTime;
  final DateTime depDateTime;
  final DateTime arrDateTime;
  OutpassStatus outpassStatus = OutpassStatus.Pending;

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
