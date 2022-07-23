//
//  ContentView.swift
//  ToDo
//
//  Created by 付铭 on 2022/7/12.
//

import SwiftUI
/*
struct ContentView: View {

    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()

    let cornerRadius: CGFloat = 7

    @State private var isExpanded = true
    @State private var input = ""
    @State private var showNew = false

    init() {

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "navTitle") as Any]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "navTitle") as Any]
        navBarAppearance.backgroundColor = UIColor(named: "theme")

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        //UIScrollView.appearance().backgroundColor = UIColor(named: "theme")
        //UIScrollView.appearance().backgroundColor = UIColor(named: "theme") //TODO: 会影响Text field组件
        //UINavigationBar.appearance().backgroundColor = UIColor(named: "theme") // 导航栏背景
        UINavigationBar.appearance().tintColor = UIColor(named: "navTitle") // 导航栏 左上角返回
        UINavigationBar.appearance().barTintColor = UIColor(named: "theme") // inline 导航栏标题

        UINavigationBar.appearance().isTranslucent = true
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                        ScrollView([.vertical], showsIndicators: false) {
                            VStack(spacing: 1) {
                                ForEach(taskViewModel.undoneItems.indices, id: \.self) { i in
                                    Section {
                                        NavigationLink(destination: EditTaskView(item: taskViewModel.undoneItems[i])) {
                                            HStack(spacing: 20) {
                                                Button {
                                                    taskViewModel.undoneItems[i].changeDone()
                                                    taskViewModel.itemDone(index: i)
                                                } label: {
                                                    Image(systemName: taskViewModel.undoneItems[i].done ? "checkmark.circle.fill" : "circle")
                                                            .scaleEffect(1.5)
                                                            .foregroundColor(taskViewModel.undoneItems[i].done ? Color("icon") : Color("gray"))
                                                            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                                }
                                                Text("\(taskViewModel.undoneItems[i].title)")
                                                        .foregroundColor(Color("listUndoneFont"))
                                                // 加入Spacer 使右侧图标居右放置
                                                Spacer()
                                                Button {
                                                    taskViewModel.undoneItems[i].changeFavorite()
                                                } label: {
                                                    Image(systemName: taskViewModel.undoneItems[i].favorite ? "star.fill" : "star")
                                                            .scaleEffect(1.2)
                                                            .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                                            .foregroundColor(taskViewModel.undoneItems[i].favorite ? Color("icon") : Color("gray"))
                                                            .padding(.trailing, 15)
                                                }
                                            }
                                                    .frame(width: 380, height: 50, alignment: .leading)
                                                    .padding(.leading, 15)
                                        }
                                    }
                                            .background(Color("listBackground"))
                                            .cornerRadius(cornerRadius)
                                            .padding(.top, 2)
                                    //.animation(Animation.easeOut(duration: 0.6).delay(100 * Double(i)), value: false)
                                    //.transition(.move(edge: .leading))
                                    //.frame(width: 440)
                                }


                                DisclosureGroup(isExpanded: $isExpanded) {
                                    ForEach(taskViewModel.doneItems.indices, id: \.self) { i in
                                        NavigationLink(destination: EditTaskView(item: taskViewModel.doneItems[i])) {
                                            Section {
                                                HStack(spacing: 20) {
                                                    Button {
                                                        taskViewModel.doneItems[i].changeDone()
                                                        taskViewModel.itemUndone(index: i)
                                                    } label: {
                                                        Image(systemName: taskViewModel.doneItems[i].done ? "checkmark.circle.fill" : "circle")
                                                                .scaleEffect(1.5)
                                                                .foregroundColor(taskViewModel.doneItems[i].done ? Color("icon") : Color("gray"))
                                                                .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: -5))
                                                    }
                                                    Text("\(taskViewModel.doneItems[i].title)")
                                                            .strikethrough(color: Color("listDoneFont"))
                                                            .foregroundColor(Color("listDoneFont"))
                                                    // 加入Spacer 使右侧图标居右放置
                                                    Spacer()
                                                    Button {
                                                        taskViewModel.doneItems[i].changeFavorite()
                                                    } label: {
                                                        Image(systemName: taskViewModel.doneItems[i].favorite ? "star.fill" : "star")
                                                                .scaleEffect(1.2)
                                                                .frame(maxWidth: 20, maxHeight: .infinity, alignment: .trailing)
                                                                .foregroundColor(taskViewModel.doneItems[i].favorite ? Color("icon") : Color("gray"))
                                                                .padding(.trailing, 15)
                                                    }
                                                }
                                                        .frame(width: 380, height: 50, alignment: .leading)
                                                        .padding(.leading, 15)
                                            }
                                                    .background(Color("listBackground"))
                                                    .cornerRadius(cornerRadius)
                                                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                                        }
                                    }
                                            .frame(height: 45)
                                    Spacer()
                                } label: {
                                    Button {
                                        isExpanded = !isExpanded
                                    } label: {
                                        HStack {
                                            Image(systemName: "chevron.forward")
                                                    .scaleEffect(0.8)
                                                    .rotationEffect(Angle.init(degrees: isExpanded ? 90 : 0))
                                                    .padding(.trailing, -2)
                                            Text("已完成")
                                        }
                                    }
                                            .font(.system(size: 15, weight: .bold))
                                            .frame(width: 80, height: 30)
                                            .foregroundColor(Color("navTitle"))
                                            .background(Color("theme-layer"))
                                            .cornerRadius(5)
                                            .padding(EdgeInsets(top: -5, leading: 10, bottom: 0, trailing: 0))
                                }
                                        .padding(.top, 7)
                                        .buttonStyle(PlainButtonStyle()).accentColor(.clear)

                            }.padding(.top, -1).background(Color("theme"))

                        }

                    //}

               //}
                NavigationLink(destination: EditTaskView(item: ItemModel(title: "", done: false, favorite: false))) {
                    HStack(spacing: 20) {
                        Image(systemName: "plus").font(.system(size: 25)).foregroundColor(Color("navTitle"))
                        Text("添加任务")
                                .foregroundColor(Color("navTitle")).padding(.leading, -5)
                    }
                            .frame(width: 380, height: 50, alignment: .leading)
                            .padding(.leading, 15)
                }
                        .background(Color("theme-layer"))
                        .cornerRadius(cornerRadius)
                        .padding(.top, 10)
                        .frame(width: 1000, height: 60)
                        .background(Color("theme").ignoresSafeArea(.all))

            }
                    .navigationTitle("计划").toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "person.badge.plus").font(.system(size: 20)).foregroundColor(Color("navTitle")).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                }
                                Button(action: {}) {
                                    Image(systemName: "ellipsis").font(.system(size: 20)).foregroundColor(Color("navTitle")).padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                                }
                            }
                        }
                    }


        }

                .environmentObject(taskViewModel)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
*/
