//
//  GoogleAnalyticsLauncher.swift
//  Qiiter
//
//  Created by 酒井英伸 on 2016/12/23.
//  Copyright © 2016年 pokohide. All rights reserved.
//

import Foundation

struct GoogleAnalyticsLauncher {
    
    // MARK: - Public
    static func launch() {
        guard let tracker = GAI.sharedInstance() else { return }
        tracker.tracker(withTrackId: AppConfig.GoogleAnalytics.TrackID)
        tracker.trackUncaughtExceptions = true
        tracker.dispatchInterval = 20
        tracker.logger.logLevel = .none
        //tracker.dryRun = AppInfo.isDebug
    }
}

