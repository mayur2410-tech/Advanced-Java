package com.example.studentapp.service;

import com.example.studentapp.dto.StudentDTO;
import com.example.studentapp.model.Student;
import org.springframework.data.domain.Page;

public interface StudentService {

    Student createStudent(StudentDTO studentDTO);

    Student updateStudent(Long id, StudentDTO studentDTO);

    void deleteStudent(Long id);

    Student getStudentById(Long id);

    Page<Student> getStudents(String keyword, int page, int size);

    long countStudents();
}
