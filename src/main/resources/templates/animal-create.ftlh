<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>New Big Cat</title>
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

  <!-- PAGE HEADER -->
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Create New Big Cat</h1>
    <a class="btn btn-outline-secondary" href="/cats">Back to List</a>
  </div>

  <!-- FORM (fields match BigCat.java) -->
  <form method="post" action="/cats/new" enctype="multipart/form-data" class="card p-3">
    <div class="row g-3">

      <!-- Required by @NotBlank -->
      <div class="col-md-6">
        <label class="form-label">Common Name <span class="text-danger">*</span></label>
        <input class="form-control" name="commonName" placeholder="Tiger" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Scientific Name</label>
        <input class="form-control" name="scientificName" placeholder="Panthera tigris">
      </div>

      <!-- Required by @NotBlank -->
      <div class="col-md-6">
        <label class="form-label">Internal Name <span class="text-danger">*</span></label>
        <input class="form-control" name="name" placeholder="Internal identifier (e.g., TIGER_001)" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Habitat</label>
        <input class="form-control" name="habitat" placeholder="Tropical forest">
      </div>

      <!-- Use a select so enum binding never fails -->
      <div class="col-md-4">
        <label class="form-label">Conservation Status</label>
        <select class="form-select" name="conservationStatus">
          <option value="VU" selected>VU — Vulnerable</option>
          <option value="EN">EN — Endangered</option>
          <option value="NT">NT — Near Threatened</option>
          <option value="LC">LC — Least Concern</option>
        </select>
        <div class="form-text">Must match enum values (EN, VU, NT, LC).</div>
      </div>

      <!-- Required by @NotNull (use wrapper Double) -->
      <div class="col-md-4">
        <label class="form-label">Age <span class="text-danger">*</span></label>
        <input class="form-control" name="age" type="number" min="0" step="0.1" placeholder="5.0" required>
      </div>

      <div class="col-md-4">
        <label class="form-label">Weight (kg)</label>
        <input class="form-control" name="weightKg" type="number" min="0" step="0.1" placeholder="220.5">
      </div>

      <!-- Required by @NotBlank -->
      <div class="col-12">
        <label class="form-label">Description <span class="text-danger">*</span></label>
        <textarea class="form-control" name="description" rows="4" placeholder="Short description..." required></textarea>
      </div>

      <!-- Image upload (optional) -->
      <div class="col-12">
        <label class="form-label">Image (optional)</label>
        <input class="form-control" type="file" name="image" accept="image/*">
        <div class="form-text">Choose a JPG or PNG from your computer.</div>
      </div>

    </div>

    <div class="mt-3 d-flex gap-2">
      <button class="btn btn-success" type="submit">Save</button>
      <a class="btn btn-outline-secondary" href="/cats">Cancel</a>
    </div>
  </form>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
