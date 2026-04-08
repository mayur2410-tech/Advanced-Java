<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="shell form-shell">
    <section class="panel">
        <div class="page-head">
            <div>
                <span class="eyebrow">Admin Action</span>
                <h1 class="page-title">${pageTitle}</h1>
                <p class="page-subtitle">Create or update student information with server-side validation.</p>
            </div>
            <a class="button-link" href="${pageContext.request.contextPath}/students">Back to Dashboard</a>
        </div>

        <form:form modelAttribute="studentDTO" action="${pageContext.request.contextPath}${formAction}" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <div class="form-grid">
                <div class="form-field">
                    <label class="form-label" for="name">Student Name</label>
                    <form:input path="name" id="name" placeholder="Enter full student name"/>
                    <form:errors path="name" cssClass="inline-error" element="div"/>
                </div>

                <div class="form-field">
                    <label class="form-label" for="course">Course</label>
                    <form:input path="course" id="course" placeholder="Enter current course"/>
                    <form:errors path="course" cssClass="inline-error" element="div"/>
                </div>

                <div class="form-field full">
                    <label class="form-label" for="email">Email Address</label>
                    <form:input path="email" id="email" placeholder="Enter student email"/>
                    <form:errors path="email" cssClass="inline-error" element="div"/>
                </div>
            </div>

            <div class="form-actions">
                <button class="button" type="submit">Save Student</button>
                <a class="button ghost" href="${pageContext.request.contextPath}/students">Cancel</a>
            </div>
        </form:form>
    </section>
</main>
</body>
</html>
