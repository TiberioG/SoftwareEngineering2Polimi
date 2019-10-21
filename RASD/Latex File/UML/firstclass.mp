input metauml
beginfig(1)

Class.U("User")
("permission" : "int")
();

Class.L("Location")
("latitude" : "long", "longitude" : "long", "time": "time")
();
Class.V("Violation")
("kind": "string", "photo": "file", "date" = "date", "street" : "string", "streetNum": "int", "licencePlate" : "string")
();

Class.S("ServiceImg2Txt")
();

Class.SU("SignUp")
();
Class.LI("Login")
();



U.nw = (0, 2);
L.nw = (1, 1);
V.nw = (3, 1);
S.nw = (4,1);
SU.nw = (1, 4);
LI.nw = (1, 5);

drawObject(U);
drawObject(L);
drawObject(V);
drawObject(S);
drawObject(SU);
drawObject(LI);


endfig
end
