package com.example.demo.models;


import lombok.NoArgsConstructor;

@NoArgsConstructor
public class IssueRecord {
    public int book_id, student_id;

    public IssueRecord(int book_id, int student_id) {
        this.book_id = book_id;
        this.student_id = student_id;
    }
}
