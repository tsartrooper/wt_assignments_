package com.example.demo;

import com.example.demo.models.Book;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/books")
public class BookController {
    public static List<Book> books = new ArrayList<>();
    @GetMapping()
    public List<Book> getBooks(){
        return books;
    }

    @PostMapping()
    public Book createBook(@RequestBody Book book){
        books.add(book);
        return book;
    }
}
