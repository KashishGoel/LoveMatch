//
//  Match.swift
//  LoveMatch
//
//  Created by Kashish Goel on 2015-07-26.
//  Copyright (c) 2015 Kashish Goel. All rights reserved.
//

import Foundation

struct Match {
    let id:String
    let user:User
}

func fetchMatches (callBack: ([Match]) ->()) {
PFQuery(className: "Action").whereKey("byUser", equalTo: PFUser.currentUser()!.objectId!).whereKey("type", equalTo: "matched").findObjectsInBackgroundWithBlock { (objects, error) -> Void in
    if let matches = objects as? [PFObject] {
    
        let matchedUsers = matches.map({
            (object)->(matchID: String, userID: String) in
            (object.objectId!, object.objectForKey("toUser") as! String)
        
        
        })
        let userIDs = matchedUsers.map({$0.userID})
        PFUser.query()!
            .whereKey("objectId", containedIn: userIDs)
            .findObjectsInBackgroundWithBlock({
                objects, error in
                if let users = objects as? [PFUser] {
                    var users = reverse(users)
                    var m = Array<Match>()
                    for (index, user) in enumerate(users) {
                        m.append(Match(id: matchedUsers[index].matchID, user: pfUserToUser(user)))
                    }
                    callBack(m)
                }
            })
    
    }
    
    
    }





}