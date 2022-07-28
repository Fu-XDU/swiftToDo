//
//  CustomNavView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/23.
//
//

import SwiftUI

struct CustomNavigationView: UIViewControllerRepresentable {
    var view: Home

    func makeUIViewController(context: Context) -> UIViewController {
        let childView = UIHostingController(rootView: view)

        let controller = UINavigationController(rootViewController: childView)

        controller.navigationBar.topItem?.title = ""
        // controller.navigationBar.prefersLargeTitles = true


        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜索"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.automaticallyShowsCancelButton = true
        // controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = true
        controller.navigationBar.topItem?.searchController = searchController

//        controller.toolbar.isTranslucent = false

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
