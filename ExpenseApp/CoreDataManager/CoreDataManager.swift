//
//  CoreDataManager.swift
//  AmadaTimeOff
//
//  Created by IT Support on 8/24/18.
//  Copyright © 2018 Heriberto Prieto. All rights reserved.
//

import CoreData

typealias ProgressComplete = (_ success: Bool, _ error: Error?) -> Void
typealias ObjectReturned<T> = (_ object: T?, _ error: NSError) -> Void

struct CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataManager")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
}
