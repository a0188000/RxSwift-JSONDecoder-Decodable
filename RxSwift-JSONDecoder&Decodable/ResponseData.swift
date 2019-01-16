//
//  ResponseData.swift
//  RxSwift-JSONDecoder&Decodable
//
//  Created by EVERTRUST on 2019/1/16.
//  Copyright © 2019 EVERTRUST. All rights reserved.
//

struct ResponseData: Decodable {
    var groups: [GroupData]
}

struct GroupData: Decodable {
    var group: GroupDetails
}

struct GroupDetails: Decodable {
    var name: String
    var teams: [TeamData]
}

struct TeamData: Decodable {
    var team: TeamDetail
}

struct TeamDetail: Decodable {
    var name: String
    var logo: String
}
