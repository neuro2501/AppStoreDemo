//
//  AppStoreDemoTests.swift
//  AppStoreDemoTests
//
//  Created by NEURO on 2017. 9. 21..
//  Copyright © 2017년 develobe. All rights reserved.
//

import XCTest
@testable import AppStoreDemo

class AppStoreDemoTests: XCTestCase {
    
    var expectedAppResult:AppResult!
    
    override func setUp() {
        super.setUp()

        expectedAppResult = AppResult(ipadScreeshotUrls: [], appletvScreenshotUrls: [], artworkUrl512: "", isGameCenterEnabled: false, version: "", artistId: "", artistName: "Kakaobank", genres: [], averageUserRating: 3.0, userRatingCount: 0, userRatingCountForCurrentVersion: 0, averageUserRatingForCurrentVersion: 0.0, trackContentRating: "", currentVersionReleaseDate: "", releaseNotes: "", screenshotUrls: [], desc: "", sellerName: "", sellerUrl: "", fileSizeBytes: "153947136", supportedDevices: [], minimumOsVersion: "", languageCodesISO2A: "")
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAppResultDecode() {
        
        let jsonDict = ["averageUserRating":3.0,"artistName":"Kakaobank","fileSizeBytes":"153947136"] as JSONDictionary
        let actualAppResult = AppResult.decode(jsonDict: jsonDict)
        
        XCTAssertEqual(expectedAppResult, actualAppResult)
        
    }
    
    func testAppResultUserRatingCountForCurrentVersion(){
        if expectedAppResult.userRatingCountForCurrentVersion > 20 {
            XCTAssertTrue(expectedAppResult.hasMuchUserRatingCountForCurrentVersion)
            XCTAssertEqual(expectedAppResult.userRatingCountForCurrentVersionDesc(), "\(expectedAppResult.userRatingCountForCurrentVersion)개의 평가")
        }else{
            XCTAssertFalse(expectedAppResult.hasMuchUserRatingCountForCurrentVersion)
            XCTAssertEqual(expectedAppResult.userRatingCountForCurrentVersionDesc(), "평가부족")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
