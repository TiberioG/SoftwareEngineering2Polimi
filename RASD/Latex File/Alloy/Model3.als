open util/boolean
//sig string {}

//sig Name, Surname{}
sig Email, Password{}


abstract sig User {

 //name: one Name,
 //surname:  some Surname,
  email: one Email,
  password: some Password,
  accessLevel: one Bool,
  	minedInfo: some MinedInfo,
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

  latitude: one Int ,
  longitude:one Int

  }

sig Photo {}

sig Violation {

	location: one Location,
	addr: some ReverseGioCoding,
 	 reporter: one EndUser,
  //type: one string,
 	 photo: one Photo,
 	 licensePlate: one ALPR, 
 

}

sig ReverseGioCoding {

  loc: some Location,
  //addr: one string

}{#ReverseGioCoding = 1}

sig ALPR { 

  picture: some Photo  ,
 // licenseP: one string

}{ #ALPR = 1}



abstract sig MinedInfo {

  violations: some Violation,

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
		
	violations: one Violation,
	valid: one Bool,
	approved: one Bool,
}
{
	valid = True
	approved= True	
}



//Two different users can’t have the same Location
fact NoSameGPSForDifferentUsers {
	no disjoint u1, u2 : EndUser |  
	u1.userLocation = u2.userLocation

}


//Two different Locations can’t have the same Reverse Address
fact NoSameGPSForDifferentReverseGio {
	no disjoint revGio1, revGio2: ReverseGioCoding |
	revGio1.loc = revGio2.loc

}


fact NoSamePhotoForDifferentViolation {
	no disjoint v1,v2 : Violation |
	v1.photo = v2.photo
}


//Two different Violatins can’t report by the same user at the same time
fact NoSameViolationForDiffReporter{
	no disjoint v1, v2 : Violation |
	v1.reporter = v2.reporter
}


//Each ticket should issue by onle one Authority
fact EachTicketOneAuthority { 
	all t: Ticket | one au: Authority | 
	au.tickets = t
}

//Two diﬀerent users can’t have the same email
fact NoSameEmailForDiﬀerentUsers {
no disjoint u1, u2 : User |
u1.email = u2.email
}


//Two different users can't request for the same MinedInformation
fact NoSameMinedInfoForDiﬀerentUsers {

all disjoint u1,u2: User | 	u1.minedInfo != u2.minedInfo

/*	no disjoint u1,u2: User | 
	u1.minedInfo = u2.minedInfo
*/
}

//Number of Locations should be equall to number of Users
fact EqualUserAndLocation{ 
#EndUser = #Location
}

//fact {all u: User | some n: Name | u.name = n}
//fact {all u: User | all n: Surname | u.surname = n}

//End users should only be allowed to access Mine street not mined offenders
fact EndUserRelateOnlyMinedStreet {
 	 all user: EndUser |
	 user.minedInfo = MinedStreet
}

//There is only one ALPR Entity who is responsible to process Photos
fact EachPhotoBelongsAlpr {
	 all ph: Photo|
 	one alpr: ALPR |
 	alpr.picture = ph
}


//The location of an EndUSers should be equal to reverse giocodding location
fact EqualLocationForEndUserAndGio  {
	one revGio: ReverseGioCoding|
 	one u: EndUser |
	 revGio.loc = u.userLocation
}

//A violation and an Enduser should have the same location
fact EqualLocationForViolationAndEndUser {
	all viol: Violation |
 	some u:EndUser|
	 viol.location = u.userLocation
}


//For each violation there should be only one corresponding ticket
fact EachViolatioContainsOneTicket {
	one t: Ticket ,  v:Violation |
	 t.violations = v
}

 //****************ASSERTIONS*************
//Two different users should have two different Emails
assert noTwoUserWithSameEmail {
no disjoint u1, u2: User |
u1.email =  u2.email
}
check noTwoUserWithSameEmail for 2

//Two different Tickets should not be issued for one violation
assert noTwoTicketsForOneViolatios{
no disjoint t1, t2: Ticket |
t1.violations =  t2.violations
}
check noTwoTicketsForOneViolatios for 2

//an Enduser shouldn't be allowed to access MinedOffender
assert EndUseCanNotAccessMinedOffender{
no  u: EndUser | some m:MinedOffender|
u.minedInfo=  m
}
check EndUseCanNotAccessMinedOffender for 2


pred showViolation {
#Password >=1

}
run showViolation for 2



