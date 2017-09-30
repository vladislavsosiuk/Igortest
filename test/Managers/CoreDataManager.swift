//
//  CoreDataManager.swift
//  test
//
//  Created by air on 30.09.17.
//  Copyright © 2017 VladOS. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "coreDataModel", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func containsPosts()->Bool{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataPost")
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            return results.count>0
        } catch {
            print(error)
        }
        return false
    }
    func getPostsFromCore()->[Post]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DataPost")
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            var posts:[Post]? = [Post]()
            for dataPost in results as! [DataPost]{
                let post = Post(userId: Int(dataPost.userId), id: Int(dataPost.id), title: dataPost.title!, body: dataPost.body!)
                posts?.append(post)
            }
            return posts
        } catch {
            print(error)
        }
        return nil
    }
    func setPostsToCore(posts: [Post]?){
        if let unwrPosts = posts{
            for post in unwrPosts{
                let entityDescription = NSEntityDescription.entity(forEntityName: "DataPost", in: self.managedObjectContext)
        
        // Создание нового объекта
            let managedObject = DataPost(entity: entityDescription!, insertInto: self.managedObjectContext)
        
        // Установка значения атрибута
        
        managedObject.id = Int32(post.id!)
                managedObject.userId = Int32(post.userId!)
                managedObject.title = post.title
                managedObject.body = post.body
        
        
        
        // Запись объекта
        
            }
            do{
                try managedObjectContext.save()
            }catch{
                
            }
        } else{
            return
        }
    }
    func signUp(email: String, password:String, birthday: Date){
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: self.managedObjectContext)
        
        // Создание нового объекта
        let managedObject = User(entity: entityDescription!, insertInto: self.managedObjectContext)
        
        // Установка значения атрибута
        
        managedObject.email = email
        managedObject.password = password
        managedObject.loginedUser = true
        
        
        // Запись объекта
        
    
        do{
            try managedObjectContext.save()
        }catch{
    
        }        
    }
    
    func login(email: String, password: String)->Bool{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        var predicates = [NSPredicate]()
        
        predicates.append(NSPredicate(format: "email == %@", email))
        predicates.append(NSPredicate(format: "password == %@", password))
        
        let compoundPredicate = NSCompoundPredicate.init(type: .and, subpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        
        
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            let user = results[0] as! User
            user.loginedUser = true
            return results.count>0
        } catch {
            print(error)
        }
        return false
    }
    func isLogined()->Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "loginedUser == %@", NSNumber(booleanLiteral: true))
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)            
            return results.count>0
        } catch {
            print(error)
        }
        return false
    }
}
