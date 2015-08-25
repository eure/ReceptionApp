//
//  CallTransaction.swift
//  Reception
//
//  Created by Hiroshi Kimura on 8/18/15.
//  Copyright © 2015 eureka. All rights reserved.
//

import Parse

class AppointTransaction: Transaction {
    
    var customer: Customer?
    var account: Account
    
    init(account: Account) {
        
        self.account = account
    }
    
    func toPFObject() -> PFObject? {
        
        guard let customer = self.customer else {
            return nil
        }
        
        let object = PFObject(className: "Transaction")
        object["name"] = customer.name
        object["company_name"] = customer.companyName
        object["mail_address"] = customer.mailAddress
        object["persons_count"] = customer.numberOfPersons
        object["contact_to"] = account.nameEn
        
        return object
    }
    
    func saveToParse() {
        
        if let object = self.toPFObject() {
            object.saveInBackgroundWithBlock { (success, error) -> Void in
                
            }
        }
    }
}