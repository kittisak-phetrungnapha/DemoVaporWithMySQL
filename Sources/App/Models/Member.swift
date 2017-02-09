//
//  Member.swift
//  DemoVaporWithMySQL
//
//  Created by Kittisak Phetrungnapha on 2/9/2560 BE.
//
//

import Foundation

//Importing the Vapor framework to make the model support dependencies
import Vapor

//Importing Fluent which is Vapors powering of databases and tables
import Fluent

//Subclassing our Member model from 'Model' (Vapors magic model object)

final class Member: Model {
    
    //Vapor uses 'Node' as their Model ids. This is the datatype that they use to make lookup and look at the primary key in the DB's.
    
    var id: Node?
    
    //Add your properties like you normally would in iOS
    var firstName: String
    var lastName: String
    var jobPosition: String
    var salary: Int
    
    //Convinience method for instanciation of our object
    init(firstName: String, lastName: String, jobPosition: String,salary: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.jobPosition = jobPosition
        self.salary = salary
    }
    
    //Adding one of Vapors protocols to conform to the 'Model' object. This basically makes sure that data is mapped correctly when getting extracted from a data source such as a DB.
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        //We are making this underscored because that's how we normally name attributes in a database table
        
        firstName = try node.extract("first_name")
        lastName = try node.extract("last_name")
        jobPosition = try node.extract("job_position")
        
        salary = try node.extract("salary")
    }
    
    //makeNode makes sure that data can be saved into the given database (this is made super dynamic)
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            //We are making this underscored because that's how we normally name attributes in a database table
            
            "first_name": firstName,
            "last_name": lastName,
            "job_position": jobPosition,
            "salary": salary
            ])
    }
    
}

//This is Vapor way of making migrations, leave them empty for now. We will add it later

extension Member: Preparation {
    static func prepare(_ database: Database) throws {
        //Adding our actual migration table and attributes. We are first defining the name of the database table and afterwards what attributes the table should have.
        
        try database.create("members") { members in
            members.id()
            members.string("first_name")
            members.string("last_name")
            members.string("job_position")
            members.int("salary")
        }
    }
    
    //This makes sure it gets deleted when reverting the projects database
    static func revert(_ database: Database) throws {
        try database.delete("members")
    }
    
}
