//
//  DataPersistenceManager.swift
//  MarvelApp
//
//  Created by Tobi on 19/09/2023.
//

import Foundation
import UIKit
import CoreData

final class DataPersistenceManager {

    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }

    static let shared = DataPersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ItemModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func addToFavourite(_ data: OverviewInformation, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = persistentContainer.viewContext
        let item = Item(context: context)
        item.id = Int64(data.id)
        item.thumbnailURL = data.thumbnail.path + "." + data.thumbnail.extension
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }

    func fetchFromDatabase(completion: @escaping (Result<[Item], Error>) -> Void) {
        let context = persistentContainer.viewContext

        let request: NSFetchRequest<Item>

        request = Item.fetchRequest()

        do {
            let users = try context.fetch(request)
            completion(.success(users))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }

    func deleteInDatabase(_ item: Item, completion: @escaping (Result<Void, Error>) -> Void) {
        let context = persistentContainer.viewContext

        context.delete(item)

        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }

    func checkEntityExists(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "url == %d", id)
        var entitiesCount = 0

        do {
            let context = persistentContainer.viewContext
            entitiesCount = try context.count(for: fetchRequest)
        } catch {
            print("error executing fetch request: \(error)")
        }

        return entitiesCount > 0
    }
}
