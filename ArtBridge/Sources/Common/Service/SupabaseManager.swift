//
//  SupabaseManager.swift
//  ArtBridge
//
//  Created by 김창규 on 1/25/25.
//

import Foundation
import Supabase

class SupabaseManager {
    static let shared = SupabaseManager()
    
    private init() {}
    
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://siqqojzclugpskrqnwyu.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNpcXFvanpjbHVncHNrcnFud3l1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc3MjQ1OTEsImV4cCI6MjA1MzMwMDU5MX0.5KO21z7blCnF9kUlr5FM6GGY2tABEHeqvqbbD-gvKhA"
    )
}
