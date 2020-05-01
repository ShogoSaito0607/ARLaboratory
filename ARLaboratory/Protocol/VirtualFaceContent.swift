//
//  VirtualFaceContent.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import ARKit

protocol VirtualFaceContent {
    func update(withFaceAnchor: ARFaceAnchor)
}

typealias VirtualFaceNode = VirtualFaceContent & SCNNode
