<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Edit: ${animal.commonName!animal.scientificName!('Animal ' + animal.bigCatId)}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-4">

  <!-- NAVBAR (consistent across templates) -->
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

  <!-- FORM: match create form structure + multipart for image -->
  <form method="post" action="/cats/update/${animal.bigCatId}" enctype="multipart/form-data" class="card p-3">

    <!-- Keep id for binding -->
    <div class="mb-3">
      <label class="form-label">ID</label>
      <input class="form-control" value="${animal.bigCatId}" readonly>
      <input type="hidden" name="bigCatId" value="${animal.bigCatId}">
    </div>

    <div class="row g-3">
      <!-- Required by @NotBlank -->
      <div class="col-md-6">
        <label class="form-label">Common Name <span class="text-danger">*</span></label>
        <input class="form-control" name="commonName" value="${animal.commonName!}" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Scientific Name</label>
        <input class="form-control" name="scientificName" value="${animal.scientificName!}">
      </div>

      <!-- Required by @NotBlank -->
      <div class="col-md-6">
        <label class="form-label">Internal Name <span class="text-danger">*</span></label>
        <input class="form-control" name="name" value="${animal.name!}" required>
      </div>

      <div class="col-md-6">
        <label class="form-label">Habitat</label>
        <input class="form-control" name="habitat" value="${animal.habitat!}">
      </div>

      <!-- Use a select so enum binding never fails -->
      <div class="col-md-4">
        <label class="form-label">Conservation Status</label>
        <select class="form-select" name="conservationStatus">
          <option value="VU" <#if animal.conservationStatus?string == "VU">selected</#if>>VU — Vulnerable</option>
          <option value="EN" <#if animal.conservationStatus?string == "EN">selected</#if>>EN — Endangered</option>
          <option value="NT" <#if animal.conservationStatus?string == "NT">selected</#if>>NT — Near Threatened</option>
          <option value="LC" <#if animal.conservationStatus?string == "LC">selected</#if>>LC — Least Concern</option>
        </select>
        <div class="form-text">Must match enum values (EN, VU, NT, LC).</div>
      </div>

      <!-- Required by @NotNull (wrapper Double) -->
      <div class="col-md-4">
        <label class="form-label">Age <span class="text-danger">*</span></label>
        <input class="form-control" name="age" type="number" min="0" step="0.1" value="${animal.age!}" required>
      </div>

      <div class="col-md-4">
        <label class="form-label">Weight (kg)</label>
        <input class="form-control" name="weightKg" type="number" min="0" step="0.1" value="${animal.weightKg!}">
      </div>

      <!-- Required by @NotBlank -->
      <div class="col-12">
        <label class="form-label">Description <span class="text-danger">*</span></label>
        <textarea class="form-control" name="description" rows="4" required>${animal.description!}</textarea>
      </div>

      <!-- Existing image preview (if present) -->
      <#if animal.imageUrl?? && animal.imageUrl?length gt 0>
        <div class="col-12">
          <label class="form-label">Current Image</label><br>
          <img src="${animal.imageUrl}" alt="${animal.commonName!'cat'}"
               class="img-fluid rounded border" style="max-height:240px;">
        </div>
      </#if>

      <!-- Replace image (optional) -->
      <div class="col-12">
        <label class="form-label">Replace Image (optional)</label>
        <input class="form-control" type="file" name="image" accept="image/*">
        <div class="form-text">Choose a JPG or PNG to replace the current image.</div>
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
