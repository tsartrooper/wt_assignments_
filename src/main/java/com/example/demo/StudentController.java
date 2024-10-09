package com.example.demo;


import com.example.demo.models.Student;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/students")
public class StudentController {
    public static List<Student> students = new ArrayList<>();

    @GetMapping()
    public List<Student> getStudents(){
        return students;
    }

    @PostMapping()
    public Student postStudent(@RequestBody Student student){
        students.add(student);
        return student;
    }



}
