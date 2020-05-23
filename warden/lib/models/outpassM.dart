class Outpass {
  final String regID;
  final String name;
  final int roomNum;
  final int phoneNum;
  final String outpassID;
  final String location;
  final String reqDateTime;
  final String depDateTime;
  final String arrDateTime;
  String outpassStatus = 'Pending';

  Outpass({
    this.regID,
    this.name,
    this.roomNum,
    this.phoneNum,
    this.outpassID,
    this.location,
    this.reqDateTime,
    this.depDateTime,
    this.arrDateTime,
    this.outpassStatus,
  });

}
