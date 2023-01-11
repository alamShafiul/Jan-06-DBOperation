//
//  NotesModel+CoreDataProperties.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 10/1/23.
//
//

import Foundation
import CoreData


extension NotesModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesModel> {
        return NSFetchRequest<NotesModel>(entityName: "NotesModel")
    }

    @NSManaged public var date: String?
    @NSManaged public var content: String?

}

extension NotesModel : Identifiable {

}
