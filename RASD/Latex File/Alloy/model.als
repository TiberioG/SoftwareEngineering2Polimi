open util/boolean
sig string {}





abstract sig User {

  name: one string,
  surname:  one string,
  address: one string,
  email: one string,
  password: one string,
  userLocation: one Location,
  accessLevel: one Bool,

}

sig EndUser extends User{



}

sig Authority extends User{}

sig Location {

  latitude: Int ,
  longitude: Int

  }{


}

sig Photo {}

sig Violation {


  reporter: one EndUser,
  type: one string,
  photo: some Photo,
  alpr: one ALPR

}

sig ReverseGioCoding {

  loc: Location,
  addr: one string

}

sig ALPR {  //remember to add somethin to tell it's only one

  picture: one Photo,
  licenseP: one string

}

abstract sig MinedInfo {

  userRequest: one User,


}

sig MinedStreet extends MinedInfo{

  name: some string,
  frequency: some Int,
  location : one Location,

}


sig MinedOffender extends MinedInfo{

  n_Violations: one Int,
  licensePlate: one Int,
  uuid: one Int

}

pred show {}
run show
