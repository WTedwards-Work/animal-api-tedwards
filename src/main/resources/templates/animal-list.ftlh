<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Big Cats</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1>Big Cats</h1>
    <a href="/cats/new" class="btn btn-success">Add New Cat</a>
  </div>

  <table class="table table-striped">
    <thead>
      <tr>
        <th>ID</th>
        <th>Common Name</th>
        <th>Habitat</th>
        <th>Status</th>
        <th>Age</th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <#list catList as cat>
        <tr>
          <td>${cat.id}</td>
          <td><a href="/cats/${cat.id}">${cat.commonName}</a></td>
          <td>${cat.habitat}</td>
          <td>${cat.status}</td>
          <td>${cat.age}</td>
          <td class="text-end">
            <a class="btn btn-sm btn-primary" href="/cats/${cat.id}/edit">Edit</a>
            <a class="btn btn-sm btn-danger" href="/cats/delete/${cat.id}" onclick="return confirm('Delete this cat?')">Delete</a>
          </td>
        </tr>
      </#list>
    </tbody>
  </table>
</body>
</html>
