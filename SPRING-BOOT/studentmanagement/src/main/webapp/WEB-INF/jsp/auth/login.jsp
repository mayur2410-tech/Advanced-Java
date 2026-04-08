<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
</head>
<body>
<section class="auth-shell">
    <div class="auth-card">
        <div class="auth-showcase">
            <span class="eyebrow">Student Management</span>
            <h1>Secure records. Clean workflow. JSP frontend.</h1>
            <p>
                Manage student information with role-based access, streamlined search,
                and an admin workflow built on Spring Boot, Spring Security, JPA, and JSP.
            </p>

            <div class="showcase-points">
                <div class="showcase-point">Authentication and authorization with `ADMIN` and `USER` roles.</div>
                <div class="showcase-point">Student CRUD, validation, pagination, and search in one flow.</div>
                <div class="showcase-point">Server-rendered JSP UI connected directly to Spring MVC controllers.</div>
            </div>
        </div>

        <div class="auth-form">
            <span class="pill">Sign In</span>
            <h2>Welcome back</h2>
            <p>Use your account credentials to enter the student dashboard.</p>

            <c:if test="${param.error eq 'true'}">
                <div class="auth-message">Invalid username or password.</div>
            </c:if>
            <c:if test="${param.logout eq 'true'}">
                <div class="flash">You have been logged out successfully.</div>
            </c:if>
            <c:if test="${param.registered eq 'true'}">
                <div class="flash">Registration completed. You can log in now.</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

                <div class="form-field">
                    <label class="form-label" for="username">Username</label>
                    <input id="username" name="username" type="text" placeholder="Enter your username" required>
                </div>

                <div class="form-field">
                    <label class="form-label" for="password">Password</label>
                    <input id="password" name="password" type="password" placeholder="Enter your password" required>
                </div>

                <div class="form-actions">
                    <button class="button" type="submit">Login</button>
                </div>
            </form>

            <div class="auth-links">
                New user? <a href="${pageContext.request.contextPath}/register">Create an account</a>
            </div>
        </div>
    </div>
</section>
</body>
</html>
