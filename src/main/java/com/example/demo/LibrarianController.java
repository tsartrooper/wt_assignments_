package com.example.demo;


import com.example.demo.models.Book;
import com.example.demo.models.IssueRecord;
import com.example.demo.models.Librarian;
import com.example.demo.models.Student;
import org.springframework.web.bind.annotation.*;

import java.util.LinkedList;
import java.util.List;
import java.util.ListResourceBundle;

@RestController
@RequestMapping("/librarian")
public class LibrarianController {
    Librarian librarian;
    List<IssueRecord> records = new LinkedList<>();


//endpoint to create a librarian

    @PostMapping
    public boolean createLibrarian(@RequestBody Librarian librarian){
        if(this.librarian != null){
            return false;
        }
        this.librarian = librarian;

        return true;
    }


//    endpoint to issue records

    @PostMapping("/issue_book")
    public boolean issueBook(@RequestBody IssueRecord issueRecord){
        Book book = getBookById(issueRecord.book_id);
        Student student = getStudentById(issueRecord.student_id);

        if(book != null && student != null){
            records.add(issueRecord);
            return true;
        }

        return false;
    }

//    endpoint to collect back an issued book

    public boolean collectBook(@RequestBody IssueRecord issueRecord){
        for(IssueRecord issueRecord1 : records){
            if(issueRecord1.book_id == issueRecord.book_id
                    && issueRecord1.student_id == issueRecord.student_id){
                records.remove(issueRecord1);
                return true;
            }
        }
        return false;
    }

//    endpoint to get issue records

    @ResponseBody
    @GetMapping("/issue_records")
    public List<IssueRecord> getIssueRecords(){
        return this.records;
    }



//helper methods

    public Book getBookById(int id){
        for(Book book : BookController.books){
            if(book.id == id){
                return book;
            }
        }
        return null;
    }


    public Student getStudentById(int id){
        for(Student student : StudentController.students){
            if(student.id == id){
                return student;
            }
        }

        return null;
    }



}
