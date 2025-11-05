<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>New Big Cat</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

  <div class="d-flex justify-content-between align-items-center mb-3">
    <h1 class="mb-0">Create New Big Cat</h1>
    <a class="btn btn-outline-secondary" href="/cats">Back to List</a>
  </div>

  <!-- IMPORTANT: input names must match BigCat fields exactly -->
  <form method="post" action="/cats/new" class="card p-3">
    <div class="row g-3">

      <div class="col-md-6">
        <label class="form-label">Common Name</label>
        <input class="form-control" name="commonName" placeholder="Tiger" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Scientific Name</label>
        <input class="form-control" name="scientificName" placeholder="Panthera tigris">
      </div>

      <div class="col-md-6">
        <label class="form-label">Internal Name</label>
        <input class="form-control" name="name" placeholder="Internal identifier (optional)">
      </div>

      <div class="col-md-6">
        <label class="form-label">Habitat</label>
        <input class="form-control" name="habitat" placeholder="Tropical forest">
      </div>

      <div class="col-md-4">
        <label class="form-label">Conservation Status</label>
        <input class="form-control" name="conservationStatus" placeholder="EN / VU / NT / LC">
      </div>

      <div class="col-md-4">
        <label class="form-label">Age</label>
        <input class="form-control" name="age" type="number" min="0" step="0.1" placeholder="5.0">
      </div>

      <div class="col-md-4">
        <label class="form-label">Weight (kg)</label>
        <input class="form-control" name="weightKg" type="number" min="0" step="0.1" placeholder="220.5">
      </div>

      <div class="col-12">
        <label class="form-label">Description</label>
        <textarea class="form-control" name="description" rows="4" placeholder="Short description..."></textarea>
      </div>

    </div>

    <div class="mt-3 d-flex gap-2">
      <button class="btn btn-success" type="submit">Save</button>
      <a class="btn btn-outline-secondary" href="/cats">Cancel</a>
    </div>
  </form>

</body>
</html>
