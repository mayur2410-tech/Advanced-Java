package com.example.studentapp.config;

import com.example.studentapp.service.AuthService;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer {

    private final AuthService authService;

    public DataInitializer(AuthService authService) {
        this.authService = authService;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void seedAdminUser() {
        authService.createDefaultAdmin();
    }
}
