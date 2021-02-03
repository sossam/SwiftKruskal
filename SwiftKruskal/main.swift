//
//  main.swift
//  SwiftKruskal
//
//  Created by 김소은 on 2021/02/01.
//

import Foundation

typealias edge = (Int, String, String)

func kruskal(vertices: [String], edges: [edge]) -> [edge] {
    var mst: [edge] = []
    
    var edges = edges.sorted { $0.0 < $1.0 }
    var rank: [String: Int] = [:]
    var parent: [String: String] = [:]
    
    for vertice in vertices {
        rank.updateValue(0, forKey: vertice)
        parent.updateValue(vertice, forKey: vertice)
    }
    
    func find(_ node: String) -> String {
        if node != parent[node]! {               // 루트 노드 찾아야만 재귀 탈출
            parent[node] = find(parent[node]!)
        }
        return parent[node]!
    }
    
    func union(_ nodeV: String, _ nodeU: String) {
        let rankV = find(nodeV)
        let rankU = find(nodeU)
        
        if rankV > rankU {
            parent[rankU] = rankV
        } else {
            parent[nodeV] = nodeU
            if rankV == rankU {
                rank[nodeU]! += 1
            }
        }
    }
    
    while mst.count < (vertices.count - 1) {
        let node = edges.removeFirst()
        if find(node.1) != find(node.2) {
            union(node.1, node.2)
            mst.append(node)
        }
    }
    return mst
}
