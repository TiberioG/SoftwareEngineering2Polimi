open util/boolean
//sig string {}

abstract sig User {

  //name: one string,
  //surname:  one string,
 // address: one string,
 // email: one string,
  //password: one string,
  accessLevel: one Bool,

	minedInfo: one MinedInfo,
}

sig EndUser extends User{

  userLocation: one Location,

}{

accessLevel = False

}

sig Authority extends User{

tickets:  Ticket,
	
}{

#tickets >= 1 
accessLevel = True

}

sig Location {

  latitude: Int ,
  longitude: Int

  }




sig Photo {}

sig Violation {

	location: one Location,
	addr: one ReverseGioCoding,
  reporter: one EndUser,
  //type: one string,
  photo: one Photo,
  alpr: one ALPR,
date: one Date

}

sig ReverseGioCoding {

  loc: Location,
  //addr: one string

}{#ReverseGioCoding = 1}

sig ALPR {  //remember to add somethin to tell it's only one

  picture: some Photo  ,
 // licenseP: one string

}{ #ALPR = 1}

sig Date {}


abstract sig MinedInfo {

  violations: set Violation,


}

sig MinedStreet extends MinedInfo{
/*
 // name: some string,
  frequency: some Int,
  location : one Location,*/

}


sig MinedOffender extends MinedInfo{
/*
  n_Violations: one Int,
  licensePlate: one Int,
  uuid: one Int*/

}


sig Ticket {

		violations: set Violation,

}


fact NoSameGPSForDifferentUsers {
	no disjoint u1, u2 : EndUser |  
	u1.userLocation = u2.userLocation

}

fact NoSameGPSForDifferentReverseGio {
	no disjoint revGio1, revGio2: ReverseGioCoding |
	revGio1.loc = revGio2.loc

}

fact NoSamePhotoForDifferentViolation {
	no disjoint v1,v2 : Violation |
	v1.photo = v2.photo
}

fact NoSameViolationForDiffReporter{
	no disjoint v1, v2 : Violation |
	v1.reporter = v2.reporter
}

/*
fact NoSameTicketForDiffAu {
	no disjoint a1, a2 : Authority|
	a1.tickets = a2.tickets

}*/


fact { #Ticket >= #Authority}

fact {  all t: Ticket | one au: Authority | au.tickets = t}

fact {  some user: User | user.accessLevel = False  and user.minedInfo = MinedStreet}

fact {  all mined: MinedInfo | one us: User | us.minedInfo = mined}

fact { all ph: Photo, alpr: ALPR | alpr.picture = ph}

fact {all revGio: ReverseGioCoding, u: EndUser | revGio.loc = u.userLocation}

fact {all loc: Location |one viol: Violation | loc = viol.location}

fact {all d: Date, viol: Violation | viol.date = d}

fact {all t: Ticket ,  v:Violation | t.violations = v}

pred show {

//one Location


}
run show for 5




