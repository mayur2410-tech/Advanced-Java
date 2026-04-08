<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="shell form-shell">
    <section class="panel">
        <span class="eyebrow">Authorization</span>
        <h1 class="page-title">Access denied.</h1>
        <p class="page-subtitle">Your account is authenticated, but it does not have permission to perform that action.</p>

        <div class="banner-danger">
            Admin-only actions include adding, editing, and deleting student records.
        </div>

        <div class="form-actions">
            <a class="button" href="${pageContext.request.contextPath}/students">Back to Dashboard</a>
        </div>
    </section>
</main>
</body>
</html>
