package com.example.studentapp.service.impl;

import com.example.studentapp.dto.StudentDTO;
import com.example.studentapp.model.Student;
import com.example.studentapp.repository.StudentRepository;
import com.example.studentapp.service.StudentService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class StudentServiceImpl implements StudentService {

    private final StudentRepository studentRepository;

    public StudentServiceImpl(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @Override
    public Student createStudent(StudentDTO studentDTO) {
        String email = studentDTO.getEmail().trim().toLowerCase();
        if (studentRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Student email already exists");
        }
        Student student = new Student();
        mapToEntity(studentDTO, student);
        return studentRepository.save(student);
    }

    @Override
    public Student updateStudent(Long id, StudentDTO studentDTO) {
        Student student = getStudentById(id);
        String email = studentDTO.getEmail().trim().toLowerCase();
        if (studentRepository.existsByEmailAndIdNot(email, id)) {
            throw new IllegalArgumentException("Student email already exists");
        }
        mapToEntity(studentDTO, student);
        return studentRepository.save(student);
    }

    @Override
    public void deleteStudent(Long id) {
        Student student = getStudentById(id);
        studentRepository.delete(student);
    }

    @Override
    public Student getStudentById(Long id) {
        return studentRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Student not found"));
    }

    @Override
    public Page<Student> getStudents(String keyword, int page, int size) {
        int safePage = Math.max(page, 0);
        int safeSize = Math.min(Math.max(size, 1), 20);
        Pageable pageable = PageRequest.of(safePage, safeSize, Sort.by(Sort.Direction.DESC, "createdAt"));
        if (!StringUtils.hasText(keyword)) {
            return studentRepository.findAll(pageable);
        }
        String search = keyword.trim();
        return studentRepository.findByNameContainingIgnoreCaseOrEmailContainingIgnoreCaseOrCourseContainingIgnoreCase(
                search,
                search,
                search,
                pageable
        );
    }

    @Override
    public long countStudents() {
        return studentRepository.count();
    }

    private void mapToEntity(StudentDTO studentDTO, Student student) {
        student.setName(studentDTO.getName().trim());
        student.setEmail(studentDTO.getEmail().trim().toLowerCase());
        student.setCourse(studentDTO.getCourse().trim());
    }
}
