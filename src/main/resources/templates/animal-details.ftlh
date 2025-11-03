<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>${cat.commonName}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
  <a href="/cats" class="btn btn-link">&larr; Back to list</a>
  <h1>${cat.commonName}</h1>
  <ul class="list-group mb-3">
    <li class="list-group-item"><strong>Habitat:</strong> ${cat.habitat}</li>
    <li class="list-group-item"><strong>Status:</strong> ${cat.status}</li>
    <li class="list-group-item"><strong>Age:</strong> ${cat.age}</li>
  </ul>
  <div class="d-flex gap-2">
    <a class="btn btn-primary" href="/cats/${cat.id}/edit">Edit</a>
    <a class="btn btn-danger" href="/cats/delete/${cat.id}" onclick="return confirm('Delete this cat?')">Delete</a>
  </div>
</body>
</html>
