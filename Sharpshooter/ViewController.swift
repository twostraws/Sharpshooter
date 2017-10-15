//
//  ViewController.swift
//  Sharpshooter
//
//  Created by Paul Hudson on 15/10/2017.
//  Copyright © 2017 Paul Hudson. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBAction func showSite(_ sender: Any) {
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        NSWorkspace.shared.open(url )
    }
}

