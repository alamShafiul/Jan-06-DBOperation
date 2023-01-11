//
//  CoreDataManager.swift
//  Jan-06-DBOperations
//
//  Created by Admin on 10/1/23.
//

import Foundation
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    
    var notesModels = [NotesModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllData() {
        do {
            notesModels = try context.fetch(NotesModel.fetchRequest())
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func addData(val: String) {
        let item = NotesModel(context: context)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY-MM-HH"
        
        item.date = formatter.string(from: Date())
        item.content = val
        
        do {
            try context.save()
            notesModels.append(item)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func updateData(val: String, indexPath: IndexPath) {
        let item = notesModels[indexPath.row]
        item.content = val
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(indexPath: IndexPath) {
        let item = notesModels[indexPath.row]
        context.delete(item)
        do {
            try context.save()
            notesModels.remove(at: indexPath.row)
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
