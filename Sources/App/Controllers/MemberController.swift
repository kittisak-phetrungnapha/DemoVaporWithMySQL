//
//  MemberController.swift
//  DemoVaporWithMySQL
//
//  Created by Kittisak Phetrungnapha on 2/9/2560 BE.
//
//

import Foundation

import Vapor

//Import HTTP for getting all our response types, codes, etc..
import HTTP

//Subclass our Controller from ResourceRepresentable
final class MemberController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        
        //So get all our member objects from the database (Of course we should in the real world add some pagination, sorting, filtering etc), we are chaining our formatter method after our query method, this automatically converts the whole thing into JSON
        return try Member.all().makeNode().converted(to: JSON.self)
    }
    
    //This is where the 'post' request gets redirected to
    func create(request: Request) throws -> ResponseRepresentable {
        
        //Guard statement to make sure we are validating the data correct (we of course should also later guard for the color etc)
        guard let firstName = request.data["firstName"]?.string,
            let lastName = request.data["lastName"]?.string,
            let jobPosition = request.data["jobPosition"]?.string,
            let saraly = request.data["salary"]?.int else {
                
            //Throw a Abort response, I like using the custom status to make sure the frontends have the correct message and response code
            throw Abort.custom(status: Status.preconditionFailed, message: "Missing first name, last name, job position, or saraly.")
        }
        
        //Create a member
        var member = Member(firstName: firstName, lastName: lastName, jobPosition: jobPosition, salary: saraly)
        
        //Asking the member to save itself, the Member model can do that because it's subclassed from Vapors Model
        try member.save()
        
        //Return the newly created member
        return try member.converted(to: JSON.self)
    }
    
    //This is the function the figure out what method that should be called depending on the HTTP request type. 
    //We will here start with the get.
    func makeResource() -> Resource<Member> {
        return Resource(
            index: index,
            store: create
        )
    }
}
