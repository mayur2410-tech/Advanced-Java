<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="shell">
    <section class="panel">
        <div class="page-head">
            <div>
                <span class="eyebrow">Student Profile</span>
                <h1 class="page-title">${student.name}</h1>
                <p class="page-subtitle">Detailed record view with role-aware navigation and actions.</p>
            </div>
            <div class="toolbar-group">
                <a class="button-link" href="${pageContext.request.contextPath}/students">Back</a>
                <sec:authorize access="hasRole('ADMIN')">
                    <a class="button alt" href="${pageContext.request.contextPath}/students/${student.id}/edit">Edit</a>
                </sec:authorize>
            </div>
        </div>

        <div class="details-grid">
            <div class="detail-card">
                <div class="detail-label">Student ID</div>
                <div class="detail-value">#${student.id}</div>
            </div>
            <div class="detail-card">
                <div class="detail-label">Course</div>
                <div class="detail-value">${student.course}</div>
            </div>
            <div class="detail-card">
                <div class="detail-label">Email</div>
                <div class="detail-value">${student.email}</div>
            </div>
            <div class="detail-card">
                <div class="detail-label">Created At</div>
                <div class="detail-value">${student.createdAt}</div>
            </div>
            <div class="detail-card">
                <div class="detail-label">Last Updated</div>
                <div class="detail-value">${student.updatedAt}</div>
            </div>
            <div class="detail-card">
                <div class="detail-label">Accessible By</div>
                <div class="detail-value">Authenticated users</div>
            </div>
        </div>
    </section>
</main>
</body>
</html>
