package com.example.demo.models;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Student {
    public int id;
    public String name;
    public List<Integer> books_issued;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
