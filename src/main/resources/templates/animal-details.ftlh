<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>${animal.commonName!animal.name!('Animal ' + animal.bigCatId)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

  <!-- NAVBAR -->
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

  <!-- Header + actions -->
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">
      ${animal.commonName!animal.name!'Unnamed Animal'}
      <small class="text-muted">#${animal.bigCatId}</small>
    </h1>
    <div class="d-flex gap-2">
      <a class="btn btn-outline-secondary" href="/cats">Back to List</a>
      <a class="btn btn-primary" href="/cats/update/${animal.bigCatId}">Edit</a>
      <a class="btn btn-danger" href="/cats/delete/${animal.bigCatId}" onclick="return confirm('Delete this animal?')">Delete</a>
    </div>
  </div>

  <!-- Details card -->
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Details</h5>
      <div class="row">
        <div class="col-md-6">
          <dl class="row mb-0">
            <dt class="col-sm-4">Common Name</dt>
            <dd class="col-sm-8">${animal.commonName!'-'}</dd>

            <dt class="col-sm-4">Scientific Name</dt>
            <dd class="col-sm-8">${animal.scientificName!'-'}</dd>

            <dt class="col-sm-4">Habitat</dt>
            <dd class="col-sm-8">${animal.habitat!'-'}</dd>

            <dt class="col-sm-4">Conservation</dt>
            <dd class="col-sm-8">${animal.conservationStatus!'-'}</dd>
          </dl>
        </div>
        <div class="col-md-6">
          <dl class="row mb-0">
            <dt class="col-sm-4">Age</dt>
            <dd class="col-sm-8">${animal.age!'Unknown'}</dd>

            <dt class="col-sm-4">Weight (kg)</dt>
            <dd class="col-sm-8">${animal.weightKg!'-'}</dd>

            <dt class="col-sm-4">Internal Name</dt>
            <dd class="col-sm-8">${animal.name!'-'}</dd>

            <dt class="col-sm-4">ID</dt>
            <dd class="col-sm-8">${animal.bigCatId}</dd>
          </dl>
        </div>
      </div>

      <hr>

      <h6 class="mb-2">Description</h6>
      <p class="mb-0">${animal.description!'No description provided.'}</p>
    </div>
  </div>

  <!-- Footer actions -->
  <div class="mt-3 d-flex gap-2">
    <a class="btn btn-outline-secondary" href="/cats">Back</a>
    <a class="btn btn-primary" href="/cats/update/${animal.bigCatId}">Edit</a>
    <a class="btn btn-danger" href="/cats/delete/${animal.bigCatId}" onclick="return confirm('Delete this animal?')">Delete</a>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
