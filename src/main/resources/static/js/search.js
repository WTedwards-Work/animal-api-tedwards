// ======= CONFIG =======
const API_BASE = "/api/bigcats";

// ======= STATE =======
let animalsCache = [];

// ======= UTIL =======
const byId = (id) => document.getElementById(id);
function showAlert(message, type = "success", mountId = "alertArea") {
  const mount = byId(mountId);
  if (!mount) return;
  mount.innerHTML = `
    <div class="alert alert-${type} alert-dismissible fade show" role="alert">
      ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>`;
}
// Simple HTML escape
function escapeHtml(s) {
  return String(s ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}
function debounce(fn, ms = 200) { let t; return (...a)=>{ clearTimeout(t); t=setTimeout(()=>fn(...a), ms); }; }

// ======= INDEX: load & render =======
async function loadAnimals() {
  try {
    const res = await fetch(API_BASE);
    if (!res.ok) throw new Error(`GET failed: ${res.status}`);
    animalsCache = await res.json();

    renderAnimals(animalsCache);

    const q = new URLSearchParams(window.location.search).get("q");
    if (q && byId("searchInput")) {
      byId("searchInput").value = q;
      applySearch();
    }
  } catch (err) {
    showAlert(`Failed to load animals: ${err.message}`, "danger");
  }
}

function renderAnimals(listData) {
  const list = byId("animalList");
  const noResults = byId("noResults");
  const count = byId("count");
  if (!list) return;

  if (count) count.textContent = listData?.length ? `(${listData.length})` : "(0)";

  if (!Array.isArray(listData) || listData.length === 0) {
    list.innerHTML = `<div class="col-12 text-muted">No animals found. Try adding one.</div>`;
    if (noResults) noResults.style.display = "block";
    return;
  } else if (noResults) {
    noResults.style.display = "none";
  }

  list.innerHTML = listData.map(a => `
    <div class="col-md-4 mb-3">
      <div class="card h-100">
        <img src="${a.imageUrl || 'https://placehold.co/600x400?text=No+Image'}" class="card-img-top" alt="${escapeHtml(a.name || 'Animal')}">
        <div class="card-body d-flex flex-column">
          <h5 class="card-title">${escapeHtml(a.name)}</h5>
          <p class="text-muted mb-1">${escapeHtml(a.species || '')}</p>
          <p class="small flex-grow-1">${escapeHtml(a.description || '')}</p>
          <div class="d-flex gap-2 mt-2">
            <button class="btn btn-danger btn-sm" onclick="deleteAnimal(${a.id})">Delete</button>
          </div>
        </div>
      </div>
    </div>
  `).join("");
}

// ======= SEARCH =======
const normalize = s => (s ?? "").toString().toLowerCase();
function filterAnimals(q) {
  const query = normalize(q);
  if (!query) return animalsCache;
  return animalsCache.filter(a =>
    normalize(a.name).includes(query) ||
    normalize(a.species).includes(query) ||
    normalize(a.description).includes(query)
  );
}
function applySearch() {
  const q = byId("searchInput")?.value || "";
  const results = filterAnimals(q);

  const noResults = byId("noResults");
  if (noResults) noResults.style.display = results.length ? "none" : "block";
  renderAnimals(results);

  const url = new URL(window.location.href);
  if (q) url.searchParams.set("q", q); else url.searchParams.delete("q");
  window.history.replaceState({}, "", url);
}
const onSearchInput = debounce(applySearch, 200);

// ======= DELETE =======
async function deleteAnimal(id) {
  if (!confirm("Delete this animal?")) return;
  try {
    const res = await fetch(`${API_BASE}/${id}`, { method: "DELETE" });
    if (!res.ok) throw new Error(`DELETE failed: ${res.status}`);
    showAlert("Animal deleted.");
    await loadAnimals();
    applySearch();
  } catch (err) {
    showAlert(`Failed to delete: ${err.message}`, "danger");
  }
}
window.deleteAnimal = deleteAnimal;

// ======= ADD FORM =======
function wireAddForm() {
  const form = byId("addAnimalForm");
  if (!form) return;

  form.addEventListener("submit", async (e) => {
    e.preventDefault();
    const data = Object.fromEntries(new FormData(form).entries());

    if (!data.name || !data.species) {
      showAlert("Please provide Name and Species.", "warning");
      return;
    }
    try {
      const res = await fetch(API_BASE, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
      });
      if (!res.ok) {
        const text = await res.text();
        throw new Error(`POST failed: ${res.status} ${text}`);
      }
      showAlert("Animal created successfully!");
      form.reset();
      setTimeout(() => (window.location.href = "index.html"), 600);
    } catch (err) {
      showAlert(`Failed to create: ${err.message}`, "danger");
    }
  });
}

// ======= BOOTSTRAP =======
document.addEventListener("DOMContentLoaded", () => {
  // On index.html
  if (byId("animalList")) {
    const input = byId("searchInput");
    const searchBtn = byId("searchBtn");
    const clearBtn = byId("clearBtn");

    if (input) input.addEventListener("input", onSearchInput);
    if (searchBtn) searchBtn.addEventListener("click", applySearch);
    if (clearBtn) clearBtn.addEventListener("click", () => { byId("searchInput").value = ""; applySearch(); });

    loadAnimals();
  }
  // On new-animal-form.html
  wireAddForm();
});
