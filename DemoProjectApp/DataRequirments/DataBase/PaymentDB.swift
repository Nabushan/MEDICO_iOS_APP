//
//  PaymentDB.swift
//  DemoProjectApp
//
//  Created by nabushan-pt5611 on 17/10/22.
//

import Foundation
import SQLite3

class PaymentDB {
    func createTable() -> Bool {
        
        let createTable = sqlite3_exec(dbQueue, "CREATE TABLE IF NOT EXISTS PAYMENTOPTIONS (cardType INTEGER, cardName TEXT, cardNumber TEXT, expiryDate TEXT, cvv TEXT);", nil, nil, nil)

        if(createTable == SQLITE_OK){
            print("Successfully created Payment Options table")
            return true
        }

        print("Unable to create Payment Options table")
        return false
    }
    
    func addPaymentOption(_ card: CardDetails) {
        let query = "INSERT INTO PAYMENTOPTIONS VALUES ('\(card.cardType.rawValue)','\(card.cardName)','\(card.cardNumber)','\(card.expiryDate)','\(card.cvvNumber)');"

        var insertQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &insertQueryPointer, nil)) == SQLITE_OK {
            if(sqlite3_step(insertQueryPointer) == SQLITE_DONE){
                print("Insertion into Payment Options Table Successfull")
            }
            else{
                print("Insertion into Payment Options Table Failed")
            }
        }

        sqlite3_finalize(insertQueryPointer)
    }
    
    func dropPaymentOptionsTable() {
        var dropTablePointer: OpaquePointer?
        
        let query = "DROP TABLE PAYMENTOPTIONS"
        
        if(sqlite3_prepare_v2(dbQueue, query, -1, &dropTablePointer, nil)) == SQLITE_OK {
            if(sqlite3_step(dropTablePointer) == SQLITE_DONE) {
                print("Successfully dropped Payment Options table")
            }
            else{
                print("Failed to dropp Payment Options table")
            }
        }
    }
    
    func emptyPaymentOptionsTable() {
        let query = "DELETE FROM PAYMENTOPTIONS;"

        var deletionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &deletionQueryPointer, nil)) == SQLITE_OK {
            
            let variable = sqlite3_step(deletionQueryPointer)
            print(variable)
            if(variable == SQLITE_DONE){
                print("Successfully deleted all sample records from Payment Options table")
            }
            else{
                print("Failed to delete all sample records from Payment Options table")
            }
        }

        sqlite3_finalize(deletionQueryPointer)
    }
    
    func getRowsFromPaymentOptionsTable() -> [CardDetails] {
        var array: [CardDetails] = []
        
        let query = "SELECT * FROM PAYMENTOPTIONS;"

        print(query)
        var selectionQueryPointer: OpaquePointer?

        if(sqlite3_prepare_v2(dbQueue, query, -1, &selectionQueryPointer, nil)) == SQLITE_OK {
            while(sqlite3_step(selectionQueryPointer) == SQLITE_ROW){
                
                let cardTypeRawValue = Int(sqlite3_column_int(selectionQueryPointer, 0))
                
                let cardName = String(cString: sqlite3_column_text(selectionQueryPointer, 1))
                
                let cardNumber = String(cString: sqlite3_column_text(selectionQueryPointer, 2))
                
                let expiryDate = String(cString: sqlite3_column_text(selectionQueryPointer, 3))
                
                let cvv = String(cString: sqlite3_column_text(selectionQueryPointer, 4))
                
                let card = CardDetails(
                    cardType: PaymentType(rawValue: cardTypeRawValue) ?? .applePay,
                    cardName: cardName,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cvvNumber: cvv)
                
                array.append(card)
            }
        }

        sqlite3_finalize(selectionQueryPointer)
        return array
    }
}
