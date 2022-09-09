//  DRLoginResponse.swift
//  TestDecisionRules
//  Created by Moisés Abraham Vázquez Pérez on 08/09/22.

import Foundation

struct DRLoginResponse: Codable {
    let urlBanner: String?
    let tienePromo: Bool?
    let color: String?
    let nombre: String?
}
