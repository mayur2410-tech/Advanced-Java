package com.example.studentapp.service.impl;

import com.example.studentapp.dto.RegisterDTO;
import com.example.studentapp.model.Role;
import com.example.studentapp.model.User;
import com.example.studentapp.repository.UserRepository;
import com.example.studentapp.service.AuthService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

@Service
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Value("${app.default-admin.username:admin}")
    private String defaultAdminUsername;

    @Value("${app.default-admin.password:admin123}")
    private String defaultAdminPassword;

    public AuthServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public User registerUser(RegisterDTO registerDTO) {
        String username = registerDTO.getUsername().trim();
        if (userRepository.existsByUsername(username)) {
            throw new IllegalArgumentException("Username already exists");
        }
        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            throw new IllegalArgumentException("Passwords do not match");
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        user.setRole(Role.USER);
        return userRepository.save(user);
    }

    @Override
    public void createDefaultAdmin() {
        if (!StringUtils.hasText(defaultAdminUsername) || !StringUtils.hasText(defaultAdminPassword)) {
            return;
        }
        if (userRepository.existsByUsername(defaultAdminUsername)) {
            return;
        }

        User admin = new User();
        admin.setUsername(defaultAdminUsername);
        admin.setPassword(passwordEncoder.encode(defaultAdminPassword));
        admin.setRole(Role.ADMIN);
        userRepository.save(admin);
    }
}
