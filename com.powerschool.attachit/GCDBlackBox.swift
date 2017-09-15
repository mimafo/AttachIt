//
//  GCDBlackBox.swift
//  com.powerschool.attachit
//
//  Created by Mike Folcher on 9/14/17.
//  Copyright © 2017 Mike Folcher. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
