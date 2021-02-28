//
//  String+Trimming.swift
//  IDEHospital
//
//  Created by Kamal on 12/24/20.
//  Copyright © 2020 ahmedElbasha. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
