<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Edit: ${animal.commonName!animal.scientificName!('Animal ' + animal.bigCatId)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

  <!-- ✅ NAVBAR (consistent across templates) -->
  <nav class="navbar navbar-expand-lg bg-body-tertiary border-bottom sticky-top mb-4">
    <div class="container">
      <a class="navbar-brand fw-bold" href="/cats">Big Cat Gallery</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div id="nav" class="collapse navbar-collapse">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="/cats">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="/cats/new">Add Cat</a></li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">
      Edit Big Cat <small class="text-muted">#${animal.bigCatId}</small>
    </h1>
    <div class="d-flex gap-2">
      <a class="btn btn-outline-secondary" href="/cats/${animal.bigCatId}">Back to Details</a>
      <a class="btn btn-outline-secondary" href="/cats">Back to List</a>
    </div>
  </div>

  <!-- IMPORTANT:
       - include a hidden id so Spring binds it
       - names must match BigCat fields exactly
       - action uses /cats/update/{id} -->
  <form method="post" action="/cats/update/${animal.bigCatId}" class="card p-3">

    <div class="mb-3">
      <label class="form-label">ID</label>
      <input class="form-control" value="${animal.bigCatId}" readonly>
      <input type="hidden" name="bigCatId" value="${animal.bigCatId}">
    </div>

    <div class="row g-3">
      <div class="col-md-6">
        <label class="form-label">Common Name</label>
        <input class="form-control" name="commonName" value="${animal.commonName!}" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Scientific Name</label>
        <input class="form-control" name="scientificName" value="${animal.scientificName!}">
      </div>

      <div class="col-md-6">
        <label class="form-label">Internal Name</label>
        <input class="form-control" name="name" value="${animal.name!}">
      </div>

      <div class="col-md-6">
        <label class="form-label">Habitat</label>
        <input class="form-control" name="habitat" value="${animal.habitat!}">
      </div>

      <div class="col-md-4">
        <label class="form-label">Conservation Status</label>
        <input class="form-control" name="conservationStatus" value="${animal.conservationStatus!}">
      </div>

      <div class="col-md-4">
        <label class="form-label">Age</label>
        <input class="form-control" name="age" type="number" min="0" step="0.1" value="${animal.age!}">
      </div>

      <div class="col-md-4">
        <label class="form-label">Weight (kg)</label>
        <input class="form-control" name="weightKg" type="number" min="0" step="0.1" value="${animal.weightKg!}">
      </div>

      <div class="col-12">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="4">${animal.description!}</textarea>
      </div>
    </div>

    <div class="mt-3 d-flex gap-2">
      <button class="btn btn-primary" type="submit">Update</button>
      <a class="btn btn-outline-secondary" href="/cats/${animal.bigCatId}">Cancel</a>
      <a class="btn btn-danger ms-auto" href="/cats/delete/${animal.bigCatId}" onclick="return confirm('Delete this animal?')">Delete</a>
    </div>
  </form>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
