<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<section class="auth-shell">
    <div class="auth-card">
        <div class="auth-showcase">
            <span class="eyebrow">Create Account</span>
            <h1>Start with a user account, then work inside the dashboard.</h1>
            <p>
                New registrations are created as `USER` accounts. Administrative actions
                such as add, edit, and delete remain protected behind role-based access.
            </p>

            <div class="showcase-points">
                <div class="showcase-point">Password hashing with BCrypt.</div>
                <div class="showcase-point">Server-side validation on every form submission.</div>
                <div class="showcase-point">Direct JSP to Spring MVC flow with CSRF protection enabled.</div>
            </div>
        </div>

        <div class="auth-form">
            <span class="pill">Register</span>
            <h2>Create your account</h2>
            <p>Fill the form below to register as a standard user.</p>

            <form:form modelAttribute="registerDTO" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                <form:errors path="*" cssClass="auth-message" element="div"/>

                <div class="form-field">
                    <label class="form-label" for="username">Username</label>
                    <form:input path="username" id="username" placeholder="Choose a username"/>
                    <form:errors path="username" cssClass="inline-error" element="div"/>
                </div>

                <div class="form-field">
                    <label class="form-label" for="password">Password</label>
                    <form:password path="password" id="password" placeholder="Create a strong password"/>
                    <form:errors path="password" cssClass="inline-error" element="div"/>
                </div>

                <div class="form-field">
                    <label class="form-label" for="confirmPassword">Confirm Password</label>
                    <form:password path="confirmPassword" id="confirmPassword" placeholder="Repeat your password"/>
                    <form:errors path="confirmPassword" cssClass="inline-error" element="div"/>
                </div>

                <div class="form-actions">
                    <button class="button" type="submit">Create Account</button>
                </div>
            </form:form>

            <div class="auth-links">
                Already registered? <a href="${pageContext.request.contextPath}/login">Back to login</a>
            </div>
        </div>
    </div>
</section>
</body>
</html>
