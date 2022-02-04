//
//  Sqlite.swift
//  registration
//
//  Created by Mac on 11/19/21.
//  Copyright © 2021 ramy. All rights reserved.
//

import SQLite

class SqliteManager {
    
    private static let sharedInstance = SqliteManager()
    
    static func shared() -> SqliteManager {
        return SqliteManager.sharedInstance
    }
    
    
    private var database: Connection!
    private let userTable = Table("Users")
    private let id = Expression<Int>("id")
    private let name = Expression<String>("name")
    private let email = Expression<String>("email")
    private let address = Expression<String>("address")
    private let password = Expression<String>("password")
    private let image = Expression<Data>("image")
    
    private let mediaTable = Table("mediaTable")
    private let emailData = Expression<String>("email")
    private let mediaHistory = Expression<Data>("mediaHistory")
    private let mediaTypeData = Expression<String>("mediaTypeData")
    
    //1-
    func setupConnection() {
        do {
            let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = doc.appendingPathComponent("users").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    func setupMediaConnection() {
        do {
            let doc = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = doc.appendingPathComponent("mediaTable").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    //2-
    func createTable() {
        let createTable = self.userTable.create{ table in
            table.column(self.id, primaryKey: true)
            table.column(self.name)
            table.column(self.email, unique: true)
            table.column(self.password)
            table.column(self.image)
            table.column(self.address)
        }
        do {
            try self.database.run(createTable)
            print("table has been created")
        } catch  {
            print(error)
        }
    }
    
    func createMediaTable() {
        let createTable = self.mediaTable.create{ table in
            table.column(self.emailData)
            table.column(self.mediaHistory)
            table.column(self.mediaTypeData)
        }
        do {
            try self.database.run(createTable)
            print("table has been created")
        } catch  {
            print(error)
        }
    }
    //3-
    func insertUser(user: User) {
        let insertUser = self.userTable.insert(self.name <- user.name, self.email <- user.email, self.password <- user.password, self.address <- user.address, self.image <- user.image)
        do {
            try self.database.run(insertUser)
            print("User inserted")
        } catch  {
            print(error)
        }
    }
    
    func getAllUsers() {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                print("user id \(user[self.id]) name \(user[self.name]) email \(user[self.email])")
            }
        } catch  {
            print(error)
        }
    }
    
    func getUserWith(email: String) -> User? {
        do {
            let users = try self.database.prepare(self.userTable)
            for user in users {
                if user[self.email] == email {
                    let user = User(name: user[self.name], email: user[self.email], password: user[self.password], address: user[self.address], image: user[self.image])
                    return user
                }
            }
        } catch  {
            print(error)
        }
        return nil
    }
    
    func insertMediaTable(email: String, mediaData: Data, type: String) {
        let insertData = self.mediaTable.insert(self.emailData <- email, self.mediaHistory <- mediaData, self.mediaTypeData <- type)
        do {
            try self.database.run(insertData)
            print("User data")
        } catch  {
            print(error)
        }
    }
    
    func getMediaData(email: String) -> (Data, String)? {
        do {
            let mediaData = try self.database.prepare(self.mediaTable)
            for media in mediaData {
                if email == media[self.emailData] {
                    let data = media[self.mediaHistory]
                    let type = media[self.mediaTypeData]
                    return (data, type)
                }
            }
        } catch  {
            print(error)
        }
        return nil
    }
    
    func deleteMediaTable() {
        do {
            if try database.run(mediaTable.delete()) > 0 {
            } else {
            }
        } catch {
            print(error)
        }
    }
}
