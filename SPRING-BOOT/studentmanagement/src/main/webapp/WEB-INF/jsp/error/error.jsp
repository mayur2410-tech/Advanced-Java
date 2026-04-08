<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | Student Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/app.css">
</head>
<body>
<main class="shell form-shell">
    <section class="panel">
        <span class="eyebrow">System Error</span>
        <h1 class="page-title">Something went wrong.</h1>
        <p class="page-subtitle">The request could not be completed. Review the message below and return to the dashboard.</p>

        <div class="banner-danger">${errorMessage}</div>
        <div class="detail-card">
            <div class="detail-label">Request Path</div>
            <div class="detail-value">${path}</div>
        </div>

        <div class="form-actions">
            <a class="button" href="${pageContext.request.contextPath}/students">Back to Dashboard</a>
        </div>
    </section>
</main>
</body>
</html>
