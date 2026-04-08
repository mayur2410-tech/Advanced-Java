package com.example.studentapp.service;

import com.example.studentapp.dto.RegisterDTO;
import com.example.studentapp.model.User;

public interface AuthService {

    User registerUser(RegisterDTO registerDTO);

    void createDefaultAdmin();
}
