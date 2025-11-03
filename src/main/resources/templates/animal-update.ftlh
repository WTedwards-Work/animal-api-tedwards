<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Edit Big Cat</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
  <h1>Edit Cat</h1>
  <form action="/cats/update/${cat.id}" method="post" class="mt-3">
    <div class="mb-3">
      <label class="form-label">Common Name</label>
      <input name="commonName" class="form-control" value="${cat.commonName}">
    </div>
    <div class="mb-3">
      <label class="form-label">Habitat</label>
      <input name="habitat" class="form-control" value="${cat.habitat}">
    </div>
    <div class="mb-3">
      <label class="form-label">Status</label>
      <input name="status" class="form-control" value="${cat.status}">
    </div>
    <div class="mb-3">
      <label class="form-label">Age</label>
      <input name="age" class="form-control" value="${cat.age}">
    </div>
    <button class="btn btn-primary" type="submit">Update</button>
    <a href="/cats" class="btn btn-link">Cancel</a>
  </form>
</body>
</html>
