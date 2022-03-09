class User {
  String id;
  DateTime lastLogin;
  String name;
  String reportingManager;
  bool deactivated;
  int rewardPoints;
  String? sessionID;

  User(this.id, this.lastLogin, this.name, this.reportingManager,this.rewardPoints,
      this.deactivated);
}
