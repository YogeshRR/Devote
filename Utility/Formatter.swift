//
//  Formatter.swift
//  Devote
//
//  Created by Yogesh Raut on 27/12/24.
//

import SwiftUI

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

