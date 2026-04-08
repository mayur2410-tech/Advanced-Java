package com.example.studentapp.controller;

import com.example.studentapp.dto.StudentDTO;
import com.example.studentapp.model.Student;
import com.example.studentapp.service.StudentService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/students")
public class StudentController {

    private final StudentService studentService;

    public StudentController(StudentService studentService) {
        this.studentService = studentService;
    }

    @GetMapping
    public String listStudents(@RequestParam(defaultValue = "") String keyword,
                               @RequestParam(defaultValue = "0") int page,
                               @RequestParam(defaultValue = "5") int size,
                               Model model) {
        Page<Student> studentPage = studentService.getStudents(keyword, page, size);
        model.addAttribute("studentPage", studentPage);
        model.addAttribute("students", studentPage.getContent());
        model.addAttribute("keyword", keyword);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalStudents", studentService.countStudents());
        model.addAttribute("resultsCount", studentPage.getNumberOfElements());
        return "student/list";
    }

    @GetMapping("/{id}")
    public String studentDetails(@PathVariable Long id, Model model) {
        model.addAttribute("student", studentService.getStudentById(id));
        return "student/details";
    }

    @GetMapping("/new")
    @PreAuthorize("hasRole('ADMIN')")
    public String showCreateForm(Model model) {
        model.addAttribute("studentDTO", new StudentDTO());
        model.addAttribute("formAction", "/students/new");
        model.addAttribute("pageTitle", "Add Student");
        return "student/form";
    }

    @PostMapping("/new")
    @PreAuthorize("hasRole('ADMIN')")
    public String createStudent(@Valid @ModelAttribute("studentDTO") StudentDTO studentDTO,
                                BindingResult bindingResult,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("formAction", "/students/new");
            model.addAttribute("pageTitle", "Add Student");
            return "student/form";
        }
        try {
            studentService.createStudent(studentDTO);
        } catch (IllegalArgumentException ex) {
            bindingResult.rejectValue("email", "student.email", ex.getMessage());
            model.addAttribute("formAction", "/students/new");
            model.addAttribute("pageTitle", "Add Student");
            return "student/form";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Student added successfully");
        return "redirect:/students";
    }

    @GetMapping("/{id}/edit")
    @PreAuthorize("hasRole('ADMIN')")
    public String showEditForm(@PathVariable Long id, Model model) {
        Student student = studentService.getStudentById(id);
        StudentDTO studentDTO = new StudentDTO();
        studentDTO.setId(student.getId());
        studentDTO.setName(student.getName());
        studentDTO.setEmail(student.getEmail());
        studentDTO.setCourse(student.getCourse());

        model.addAttribute("studentDTO", studentDTO);
        model.addAttribute("formAction", "/students/" + id + "/edit");
        model.addAttribute("pageTitle", "Edit Student");
        return "student/form";
    }

    @PostMapping("/{id}/edit")
    @PreAuthorize("hasRole('ADMIN')")
    public String updateStudent(@PathVariable Long id,
                                @Valid @ModelAttribute("studentDTO") StudentDTO studentDTO,
                                BindingResult bindingResult,
                                Model model,
                                RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("formAction", "/students/" + id + "/edit");
            model.addAttribute("pageTitle", "Edit Student");
            return "student/form";
        }
        try {
            studentService.updateStudent(id, studentDTO);
        } catch (IllegalArgumentException ex) {
            bindingResult.rejectValue("email", "student.email", ex.getMessage());
            model.addAttribute("formAction", "/students/" + id + "/edit");
            model.addAttribute("pageTitle", "Edit Student");
            return "student/form";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Student updated successfully");
        return "redirect:/students";
    }

    @PostMapping("/{id}/delete")
    @PreAuthorize("hasRole('ADMIN')")
    public String deleteStudent(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        studentService.deleteStudent(id);
        redirectAttributes.addFlashAttribute("successMessage", "Student deleted successfully");
        return "redirect:/students";
    }
}
