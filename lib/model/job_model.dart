class JobModel {
  bool? validForMonth;
  String? postName;
  String? location;
  String? contract;
  String? route;
  String? timeType;//full,part
  bool? immediateStart;
  String? conStartDate;
  String? duration;
  bool? negotiateSalary;
  String? salary;

  bool? lOffer;
  bool? prime;
  bool? companyCreche;
  bool? tExpense;
  bool? giftTickets;
  bool? ticketsRes;
  bool? accommodation;
  bool? scheduleDiscussed;

  String? jobSpecs;

  Map<String, dynamic> toMap() {
    return {
      "validForMonth" : validForMonth,
      "postName" : postName,
      "location" : location,
      "contract" : contract,
      "route" : route,
      "timeType" : timeType,
      "immediateStart" : immediateStart,
      "conStartDate" : conStartDate,
      "duration" : duration,
      "negotiateSalary" : negotiateSalary,
      "salary" : salary,

      "lOffer" : lOffer,
      "prime" : prime,
      "companyCreche" : companyCreche,
      "tExpense" : tExpense,
      "giftTickets" : giftTickets,
      "ticketsRes" : ticketsRes,
      "accommodation" : accommodation,
      "scheduleDiscussed" : scheduleDiscussed,
      "jobSpecs" : jobSpecs,

    };
  }
}