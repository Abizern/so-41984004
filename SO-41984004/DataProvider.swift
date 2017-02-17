//
//  DataProvider.swift
//  SO-41984004
//
//  Created by Abizer Nasir on 17/02/2017.
//  Copyright © 2017 Abizer Nasir. All rights reserved.
//

import UIKit

/// A simple protocol for classes that are data sources for table or collection views.
protocol DataProvider: class {
    associatedtype Object

    func object(at indexPath: IndexPath) -> Object
    func numberOfItemsInSection(_ section: Int) -> Int
}

/// Protocol for delegates of `DataProviders`
protocol DataProviderDelegate: class {
    func dataProviderDidUpdate()
}

