//
//  01TodoList.swift
//  SwiftUIChallenges
//
//  Created by Guillermo Santos Barrios on 5/4/23.
//
//https://dribbble.com/shots/7933705-Project-Management-Mobile-App/attachments/513163?mode=media


import SwiftUI

struct _1TodoList: View {
    let items = [
        (section: "Design", tasks: [
            (name: "Jane Lane", time: "9 h 30 min", picture: "p1", progress: 0.25),
            (name: "Peter Altman", time: "10 hr 00 min", picture: "p2",
                progress: 0.10),
        ]),
        (section: "Development", tasks: [
            (name: "Mark Lane", time: "2 h 30 min", picture: "p3",
             progress: 1.0),
            (name: "John Smith", time: "2 hr 00 min", picture: "p4",
             progress: 1.0),
        ]),
        
    ]
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                // Header
                VStack(spacing: contentPadding * 2) {
                    HStack() {
                        Button {
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: smallButtonSize))
                                .bold()
                        }
                        .foregroundColor(Color("Dark"))
                        Spacer()
                        Button("Done") {
                            
                        }
                        .font(.system(size: smallButtonSize))
                        .tint(Color("Accent"))
                        .bold()
                        
                    }
                    Text("Ofspace Digital Agency\nWebsite")
                        .font(.title)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color("Dark"))
                }
                .padding(.horizontal, contentPadding)
                .padding(.bottom, contentPadding)
                .background(Color("Background2"))
                
                // Segmented Control
                _1SegmentedControl()
                    .padding([.vertical, .horizontal], contentPadding)
                
                // List View
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(items, id: \.section) { section in
                            HStack(spacing: 8) {
                                Text(section.section)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color("Dark"))
                                Text("(\(section.tasks.count) Assigned)")
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color("Accent"))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(contentPadding)
                            
                            ForEach(section.tasks.indices, id: \.self) { task in
                                Group {
                                    _1CardView(name: section.tasks[task].name, time: section.tasks[task].time, image: section.tasks[task].picture,
                                               progress: section.tasks[task].progress
                                    )
                                    .cardBorder(cardCount: section.tasks.count, cardIndex: task)
                                    if task < section.tasks.count - 1 {
                                        Divider()
                                            .frame(height: 0.25)
                                            .padding(.horizontal, contentPadding)
                                    }
                                }
                                .padding(.horizontal, contentPadding)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)   // Remove the custom background
            }
        }
    }
    
    // UI variables
    private let contentPadding: CGFloat = 24
    private let smallButtonSize: CGFloat = 20
}

struct _1CardBorder: ViewModifier {
    var cardCount: Int
    var cardIndex: Int
    func body(content: Content) -> some View {
        if cardIndex == 0 {
            content
                .padding(.bottom, 10)
                .cornerRadius(10)
                .padding(.bottom, -10)
        } else {
            content
                .padding(.top, 10)
                .cornerRadius(10)
                .padding(.top, -10)
        }
        
    }
}

extension View {
    func cardBorder(cardCount: Int, cardIndex: Int) -> some View {
        self.modifier(_1CardBorder(cardCount: cardCount, cardIndex: cardIndex))
    }
}


struct _1CardView: View {
    let name: String
    let time: String
    let image: String
    let progress: Double
    
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            
            
            VStack(alignment: .leading, spacing: 0) {
                Text(name)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Dark"))
                Spacer()
                    .frame(height: 4)
                Text(time)
                    .font(.callout)
                    .foregroundColor(Color("Gray"))

            }
            .frame(maxHeight: 50)
            Spacer()
            Group {
                if progress < 1 {
                    Text("\(String(format: "%.0f", progress * 100))%")
                } else {
                    Image(systemName: "checkmark")
                }
            }
                .background(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .fill(Color("Background"))
                        .rotationEffect(.degrees(-90))
                        .frame(width: circleDimensions, height: circleDimensions)
                )
                .overlay(
                    Circle()
                        .trim(from: 0, to: progress)
                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .fill(progress < 1 ? Color("Accent") : Color("Accent2"))
                        .rotationEffect(.degrees(-90))
                        .frame(width: circleDimensions, height: circleDimensions)
                )
                .fontWeight(.semibold)
                .foregroundColor(progress < 1 ? Color("Accent") : Color("Accent2"))
                .frame(width: circleDimensions, height: circleDimensions)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
        .padding(.horizontal, cardPadding * 2)
        .background(Color("Background2"))
        
    }
    
    // UI variables
    private let cardPadding: CGFloat = 12
    private let cornerRadius: CGFloat = 10
    private let circleDimensions: CGFloat = 54
}

struct _1SegmentedControl: View {
    @State private var option = 0
    let options = ["In Progress", "Assigned", "Completed"]
    var body: some View {
        HStack(spacing:2) {
            ForEach(0..<3) { i in
                Button {
                    self.option = i
                } label: {
                    Text(options[i])
                        .padding()
                }
                .font(.system(size: 14))
                .fontWeight(.semibold)
                
                .foregroundColor(option == i ? Color("Dark") : Color("Gray"))
                .frame(maxWidth: .infinity)
                .background(
                    Rectangle()
                        .fill(Color("Background2"))
                        .padding(.trailing, i == 0 ? 10 : 0)
                        .padding(.leading, i == options.count - 1 ? 10 : 0)
                        .cornerRadius(i == 0 || i == 2 ? 10: 0)
                        .padding(.trailing, i == 0 ? -10 : 0)
                        .padding(.leading, i == options.count - 1 ? -10 : 0)
                    
                )
            }
        }
        .frame(maxWidth: .infinity)
        
    }
}

struct _1TodoList_Previews: PreviewProvider {
    static var previews: some View {
        _1TodoList()
    }
}
