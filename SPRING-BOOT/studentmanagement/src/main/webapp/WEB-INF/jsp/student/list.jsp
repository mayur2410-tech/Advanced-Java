<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="shell">
    <section class="hero">
        <div class="hero-card hero-main">
            <span class="eyebrow">Dashboard</span>
            <h1 class="hero-title">Student records with secure access control.</h1>
            <p class="hero-subtitle">
                Search, browse, and manage records through a JSP interface connected directly
                to Spring MVC controllers and protected by Spring Security.
            </p>
        </div>

        <div class="hero-card hero-side">
            <div class="metric">
                <span class="metric-label">Total Students</span>
                <span class="metric-value">${totalStudents}</span>
            </div>
            <div class="metric">
                <span class="metric-label">Current Page Results</span>
                <span class="metric-value">${resultsCount}</span>
            </div>
            <div class="metric">
                <span class="metric-label">Signed In As</span>
                <span class="metric-value"><sec:authentication property="name"/></span>
            </div>
        </div>
    </section>

    <c:if test="${not empty successMessage}">
        <div class="flash">${successMessage}</div>
    </c:if>

    <section class="panel">
        <div class="toolbar">
            <form class="search-form" action="${pageContext.request.contextPath}/students" method="get">
                <input type="text" name="keyword" placeholder="Search by name, email, or course" value="${keyword}">
                <button class="button" type="submit">Search</button>
                <a class="button ghost" href="${pageContext.request.contextPath}/students">Reset</a>
            </form>

            <div class="toolbar-group">
                <sec:authorize access="hasRole('ADMIN')">
                    <a class="button alt" href="${pageContext.request.contextPath}/students/new">Add Student</a>
                </sec:authorize>
                <form action="${pageContext.request.contextPath}/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                    <button class="button ghost" type="submit">Logout</button>
                </form>
            </div>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Course</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${empty students}">
                        <tr>
                            <td class="table-empty" colspan="5">No students matched your search.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${students}" var="student">
                            <tr>
                                <td>#${student.id}</td>
                                <td>${student.name}</td>
                                <td>${student.email}</td>
                                <td>${student.course}</td>
                                <td>
                                    <div class="table-actions">
                                        <a class="button-link" href="${pageContext.request.contextPath}/students/${student.id}">View</a>
                                        <sec:authorize access="hasRole('ADMIN')">
                                            <a class="button-link" href="${pageContext.request.contextPath}/students/${student.id}/edit">Edit</a>
                                            <form action="${pageContext.request.contextPath}/students/${student.id}/delete" method="post">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                                <button class="button-danger" type="submit" onclick="return confirm('Delete this student?')">Delete</button>
                                            </form>
                                        </sec:authorize>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </div>

        <div class="pagination">
            <div class="muted">
                Page ${studentPage.number + 1} of ${studentPage.totalPages == 0 ? 1 : studentPage.totalPages}
            </div>
            <div class="pagination-links">
                <c:if test="${!studentPage.first}">
                    <a class="page-chip" href="${pageContext.request.contextPath}/students?page=${currentPage - 1}&keyword=${keyword}">Previous</a>
                </c:if>
                <c:if test="${!studentPage.last}">
                    <a class="page-chip" href="${pageContext.request.contextPath}/students?page=${currentPage + 1}&keyword=${keyword}">Next</a>
                </c:if>
            </div>
        </div>
    </section>
</main>
</body>
</html>
