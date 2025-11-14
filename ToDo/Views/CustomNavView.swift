//
//  CustomNavView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/23.
//
//

import SwiftUI

struct CustomNavigationView<Content: View>: UIViewControllerRepresentable {
    var view: Content  // 现在可以是任意 View

    func makeUIViewController(context: Context) -> UIViewController {
        let childView = UIHostingController(rootView: view)
        let controller = UINavigationController(rootViewController: childView)

        // 配置导航栏
        controller.navigationBar.topItem?.title = ""
        // controller.navigationBar.prefersLargeTitles = true

        // 搜索栏
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜索"
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.automaticallyShowsCancelButton = true
        controller.navigationBar.topItem?.searchController = searchController

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
