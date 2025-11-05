<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Big Cat Gallery</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

  <!-- HEADER -->
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Big Cat Gallery</h1>
    <a href="/cats/new" class="btn btn-success">➕ Add New Cat</a>
  </div>

  <!-- ALERT IF EMPTY -->
  <#if animalList?size == 0>
    <div class="alert alert-warning">No cats found in the database. Try adding one!</div>
  <#else>

  <!-- TABLE -->
  <div class="table-responsive">
    <table class="table table-striped align-middle">
      <thead class="table-dark">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Common Name</th>
          <th scope="col">Scientific Name</th>
          <th scope="col">Habitat</th>
          <th scope="col">Conservation</th>
          <th scope="col">Age</th>
          <th scope="col">Weight (kg)</th>
          <th scope="col" class="text-end">Actions</th>
        </tr>
      </thead>
      <tbody>
        <#list animalList as animal>
          <tr>
            <td>${animal.bigCatId}</td>
            <td>
              <a href="/cats/${animal.bigCatId}" class="fw-bold text-decoration-none">
                ${animal.commonName!animal.name!'Unnamed'}
              </a>
            </td>
            <td>${animal.scientificName!'-'}</td>
            <td>${animal.habitat!'-'}</td>
            <td>${animal.conservationStatus!'-'}</td>
            <td>${animal.age!'?'}</td>
            <td>${animal.weightKg!'-'}</td>
            <td class="text-end">
              <a class="btn btn-sm btn-info" href="/cats/${animal.bigCatId}">View</a>
              <a class="btn btn-sm btn-primary" href="/cats/update/${animal.bigCatId}">Edit</a>
              <a class="btn btn-sm btn-danger" href="/cats/delete/${animal.bigCatId}"
                 onclick="return confirm('Are you sure you want to delete this cat?');">Delete</a>
            </td>
          </tr>
        </#list>
      </tbody>
    </table>
  </div>
  </#if>

  <!-- FOOTER NAV -->
  <div class="mt-4 d-flex justify-content-between">
    <a href="/cats/new" class="btn btn-success">Add New Cat</a>
    <a href="/cats" class="btn btn-outline-secondary">Refresh List</a>
  </div>

</body>
</html>
