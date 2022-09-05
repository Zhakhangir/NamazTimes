//
//  GeneralStorageInteractor.swift
//  NamazTimes
//
//  Created by &&TairoV on 19.07.2022.
//

import Foundation
import RealmSwift

class GeneralStorageController {

    let localRealm = try! Realm()

    func writeData(name: String, owner: String, status: Bool) {
//        let data  = GeneralStorage(name: name, owner: owner, status: status)
//        try! localRealm.write {
//            localRealm.add(data)
//        }
    }

//    func getData() -> [GeneralStorage] {
//        let tasks = localRealm.objects(GeneralStorage.self)
//
//        let sortedTasks = tasks.where {
//            $0.name == "Zhakhangir"
//        }
//
//        return sortedTasks.reversed()
//    }

    func updateAll(owner: String) {
//
//        let tasks = localRealm.objects(GeneralStorage.self)
//
//        for (index, _ ) in tasks.enumerated() {
//            tasks[index].owner = owner
//        }
    }

    func delete(name: String) {

//        let tasks = localRealm.objects(GeneralStorage.self)
//
//        for (index, taskItem ) in tasks.enumerated() {
//
//            if tasks[index].name == name {
//                try! localRealm.write {
//                    localRealm.delete(taskItem)
//                }
//            }
//        }
    }

}
