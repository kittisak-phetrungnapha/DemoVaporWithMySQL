import Vapor

//Importing our new MySQL provider
import VaporMySQL

let drop = Droplet()

//Creating a route group, in this way you won't have to add the same slugs over and over again

drop.group("api") { api in
    //Adding a sub slug to our URL and redirecting all requests to the MemberController we just built.
    api.resource("members", MemberController())
}

// Add providers. This tells Vapor that we are using the VaporMySQL provider, this will bind the data to the database and the models automatically down the line
try drop.addProvider(VaporMySQL.Provider.self)

//Making sure that Vapor runs our migrations / preperations for our model(s)
drop.preparations.append(Member.self)

drop.run()
