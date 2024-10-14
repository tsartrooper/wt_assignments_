package com.example.demo;

import com.example.demo.models.Book;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import java.util.ArrayList;
import java.util.List;

@RequestMapping("/books")
@RestController
public class BookController {
    public static List<Book> books = new ArrayList<>();
    @GetMapping()
    public List<Book> getBooks(Model model){
    model.addAttribute("books", books);
        return books;
    }

    @PostMapping()
    public Book createBook(@RequestBody Book book){
        books.add(book);
        return book;
    }
}
