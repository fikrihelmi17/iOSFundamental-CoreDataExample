//
//  ViewController.swift
//  Core Data Example
//
//  Created by Fikri on 19/07/20.
//  Copyright © 2020 Fikri Helmi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard container != nil else { fatalError("This view needs a persistent container.") }
        
    }
        
    func createData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let memberEntity = NSEntityDescription.entity(forEntityName: "Member", in: managedContext)
        
        Member.setValue("fikrihelmi17@gmail.com", forKey: "email")
        memberEntity?.setValue("Fikri Helmi Setiawan", forKey: "name")
        memberEntity?.setValue("iOS Developer", forKey: "profession")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func readData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
        fetchRequest.predicate = NSPredicate(format: "id > 10")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
                    // proses result
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error). \(error.userInfo)")
        }
        
        var members: [Member] = []
        for result in results {
            let member = Member(id: result.value(forKeyPath: "id") as? Int32,
                name: result.value(forKeyPath: "name") as? String,
                email: result.value(forKeyPath: "email") as? String,
                profession: result.value(forKeyPath: "profession") as? String,
                about: result.value(forKeyPath: "about") as? String,
                image: result.value(forKeyPath: "image") as? Data)
            members.append(member)
        }
        
    }
    
    func updateData() {
        let id = 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        fetchRequest.fetchLimit = 1
        
        if let result = try? managedContext.fetch(fetchRequest), let member = result.first as? Member{
                // update nilainya
        }
            
        Member.setValue("name", forKeyPath: "name")
        Member.setValue("email", forKeyPath: "email")
        Member.setValue("profession", forKeyPath: "profession")
        Member.setValue("about", forKeyPath: "about")
        Member.setValue("image", forKeyPath: "image")
       
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
 
    func deleteData() {
        let id = 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Member")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        
        fetchRequest.fetchLimit = 1
        
        if let result = try? managedContext.fetch(fetchRequest), let member = result.first as? Member{
                // update nilainya
        }
            
        managedContext.delete(result)
       
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}

