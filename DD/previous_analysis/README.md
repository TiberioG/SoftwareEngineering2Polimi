# Sections  2

 * Weakeness: for the use case required we don't see the need to separate application servers from web server
 * Weakeness : The class diagram has a class without any relationship which is strange
 * Weakeness: the MVC pattern is not well contextualised, where is used ? it's the way each subsystem (mobile app, application server, web server) is developed or it's the general architecture?

# Sections 3 and 4

 * The requirements R5 and R8 did not manage well. Imagine that a situation where a third party has to access an individual’s data but the user refuse the request. What happen in this situation?
* The system should present different privileges for different users in order to access to data. This requirement is missed.
* Almost all of the requirements especially those related to the main functionalities expressed in RASD is well defined and their relationship with design components is correctly defined.

# Section 5

 * A good addition to the test plan would be releasing the service to a group of beta-testers before the final release
 * the verbal description of testing of every component is not so effective because it's repetitive. Adding a graph like a "GANTT of the testing" for each component showing the order of testing would be more clear
