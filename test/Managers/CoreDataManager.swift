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
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            return results.count>0
        } catch {
            Helper.logError(error: error)
        }
        return false
    }
    func getPostsFromCore()->[Post]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Post")
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest) as! [PostMO]            
            var posts:[Post]? = [Post]()
            for dataPost in results{
                let post = Post(userId: Int(dataPost.userId), id: Int(dataPost.id), title: dataPost.title!, body: dataPost.body!)
                posts?.append(post)
            }
            return posts
        } catch {
            Helper.logError(error: error)
        }
        return nil
    }
    func setPostsToCore(posts: [Post]?){
        if let unwrPosts = posts{
            for post in unwrPosts{
                let entityDescription = NSEntityDescription.entity(forEntityName: "Post", in: self.managedObjectContext)
            let managedObject = PostMO(entity: entityDescription!, insertInto: self.managedObjectContext)
        managedObject.id = Int32(post.id!)
        managedObject.userId = Int32(post.userId!)
        managedObject.title = post.title
        managedObject.body = post.body
                managedObject.user = self.getUserById(Id: post.userId!)
            }
            do{
                try managedObjectContext.save()
            }catch{
                Helper.logError(error: error)
            }
        } else{
            return
        }
    }
    func getUserById(Id: Int)->UserMO?{
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let predicate = NSPredicate(format: "userId == \(Id)")
        userFetch.predicate = predicate
        do{
            let users = try self.managedObjectContext.fetch(userFetch) as! [UserMO]
            if users.count == 1{
                return users[0]
            }
            return nil
        }catch{
            Helper.logError(error: error)
        }
        return nil
    }
    func registerNewUser(email: String, password:String, birthday: Date){
        let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: self.managedObjectContext)
        
        let managedObject = UserMO(entity: entityDescription!, insertInto: self.managedObjectContext)
        
        managedObject.email = email
        managedObject.password = password
        managedObject.loginedUser = true
        
        do{
            try managedObjectContext.save()
        }catch{
            Helper.logError(error: error)
        }        
    }
    
    func findUserByEmailAndPassword(email: String, password: String)->Bool{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        var predicates = [NSPredicate]()
        
        predicates.append(NSPredicate(format: "email == %@", email))
        predicates.append(NSPredicate(format: "password == %@", password))
        
        let compoundPredicate = NSCompoundPredicate.init(type: .and, subpredicates: predicates)
        fetchRequest.predicate = compoundPredicate
        
        do {
            let users = try self.managedObjectContext.fetch(fetchRequest) as! [UserMO]
            if users.count==0{
                return false
            }
            let user = users[0]
            user.loginedUser = true
            do{
                try managedObjectContext.save()
            }catch{
                Helper.logError(error: error)
            }
            return true
        } catch {
            Helper.logError(error: error)
        }
        return false
    }
    func loginedAlreadyUserExists()->Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "loginedUser == %@", NSNumber(booleanLiteral: true))
        do {
            let results = try self.managedObjectContext.fetch(fetchRequest)
            return results.count>0
        } catch {
            Helper.logError(error: error)
        }
        return false
    }
    func signOutUser(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "loginedUser == \(true)")
        do{
            let users = try self.managedObjectContext.fetch(request) as! [UserMO]
            if users.count==1{
                users[0].loginedUser = false
            }
        }catch{
            Helper.logError(error: error)
        }
    }
}
