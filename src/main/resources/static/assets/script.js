// ======= CONFIG =======
const API_BASE = "/api/bigcats"; // change if your controller path differs

// ======= MAIN BOOTSTRAP =======
document.addEventListener("DOMContentLoaded", () => {
  // If on the index page
  if (document.getElementById("animalList")) {
    loadAnimals();
  }

  // If on the add-animal page
  wireAddForm();
});

// ======= LOAD & DISPLAY ALL ANIMALS =======
async function loadAnimals() {
  try {
    const res = await fetch(API_BASE);
    if (!res.ok) throw new Error(`GET failed: ${res.status}`);
    const animals = await res.json();

    const list = document.getElementById("animalList");
    list.innerHTML = "";

    if (animals.length === 0) {
      list.innerHTML = `<p class="text-muted">No animals found. Add one using the "Add Animal" page.</p>`;
      return;
    }

    animals.forEach(a => {
      list.innerHTML += `
        <div class="col-md-4 mb-3">
          <div class="card h-100">
            <img src="${a.imageUrl || 'https://placehold.co/600x400?text=No+Image'}"
                 class="card-img-top"
                 alt="${escapeHtml(a.name)}">
            <div class="card-body d-flex flex-column">
              <h5 class="card-title">${escapeHtml(a.name)}</h5>
              <p class="text-muted mb-1">${escapeHtml(a.species || '')}</p>
              <p class="small flex-grow-1">${escapeHtml(a.description || '')}</p>
              <button class="btn btn-danger btn-sm mt-auto" onclick="deleteAnimal(${a.id})">Delete</button>
            </div>
          </div>
        </div>
      `;
    });
  } catch (err) {
    console.error(err);
    alert("Error loading animals: " + err.message);
  }
}

// ======= ADD NEW ANIMAL (FORM HANDLER) =======
function wireAddForm() {
  const form = document.getElementById("addAnimalForm");
  if (!form) return; // only runs on add-animal.html

  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    // Collect form data
    const payload = {
      name: form.name.value.trim(),
      species: form.species.value.trim(),
      description: form.description.value.trim(),
      imageUrl: form.imageUrl.value.trim()
    };

    // Client-side validation
    if (!payload.name || !payload.species) {
      alert("Please fill in both Name and Species.");
      return;
    }

    try {
      const res = await fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(payload)
      });

      if (!res.ok) {
        const text = await res.text();
        throw new Error(`Server responded ${res.status}: ${text}`);
      }

      alert("Animal added successfully!");
      form.reset();
      window.location.href = "index.html";
    } catch (err) {
      console.error(err);
      alert("Error adding animal: " + err.message);
    }
  });
}

// ======= DELETE ANIMAL =======
async function deleteAnimal(id) {
  if (!confirm("Delete this animal?")) return;

  try {
    const res = await fetch(`${API_BASE}/${id}`, { method: "DELETE" });
    if (!res.ok) throw new Error(`DELETE failed: ${res.status}`);
    alert("Animal deleted!");
    loadAnimals();
  } catch (err) {
    console.error(err);
    alert("Error deleting animal: " + err.message);
  }
}

// ======= HTML ESCAPE (for safety) =======
function escapeHtml(str) {
  return String(str ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}
