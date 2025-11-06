```markdown
# Animal API / MVC — CSC 340 (William Taylor Edwards)

Full-stack **Spring Boot MVC** app built on top of my Assignment 3 CRUD API.  
Stores data in **Neon (PostgreSQL)**, renders pages with **FreeMarker**, and supports **image uploads**.

---

## Demo Videos

- **FIXED CRUD Demo (A3)**  
  [Watch on OneDrive (UNCG sign-in)](https://uncg-my.sharepoint.com/:v:/g/personal/wtedwards_uncg_edu/Eb0LKHhllthMoHGH4v7_xA8Bsf9-hAeMk7fKR6v2pDAzBw?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=3LJ61e)

- **MVC Demo (A4)**  
  [Watch on OneDrive (UNCG sign-in)](https://uncg-my.sharepoint.com/:v:/g/personal/wtedwards_uncg_edu/ERAuSRMQItBFnZDeFcYAKMsBqdlIGOON5JQy7nAmWhnpqg?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=11CWQe)

---

## Overview

- **API (A3):** RESTful CRUD for `BigCat` entities.
- **MVC (A4):** Server-rendered pages (`/cats`, `/cats/new`, etc.) with FreeMarker.
- **Database:** Neon (PostgreSQL) — Hibernate auto-creates/updates schema.
- **Images:** Users can upload images; files saved to a local `uploads/` folder, served at `/images/**`.

---

## Tech Stack

- Java 17, Spring Boot 3.5.6  
- Spring MVC, Spring Data JPA, FreeMarker  
- PostgreSQL on **Neon**  
- Bootstrap 5  

---

## Project Structure (key parts)

```

src/main/java/edu/uncg/bigAnimals_api/
├── BigCat.java                  # Entity (@Table("big_cats"))
├── BigCatRepository.java        # JPA Repository
├── BigCatService.java           # Service (CRUD)
├── BigCatController.java        # REST API (/api/bigcats/*)
├── BigCatMvcController.java     # MVC pages (/cats/*), handles image upload
├── RootController.java          # "/" to redirect:/cats
└── WebConfig.java               # /images/** to local /uploads

src/main/resources/
├── templates/
│   ├── animal-list.ftlh
│   ├── animal-details.ftlh
│   ├── animal-create.ftlh
│   └── animal-update.ftlh
└── static/
└── assets/ 

````

---

## Setup & Run

### 1) Clone
```bash
git clone https://github.com/WTedwards-Work/animal-api-tedwards.git
cd animal-api-tedwards
````

### 2) Configure database (`src/main/resources/application.properties`)

```properties
spring.datasource.url=jdbc:postgresql://ep-summer-hill-ad0fdvon-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
spring.datasource.username=neondb_owner
spring.datasource.password=REPLACE_ME
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# (optional) allow larger uploads
spring.servlet.multipart.max-file-size=15MB
spring.servlet.multipart.max-request-size=15MB
```

### 3) Run

```bash
.\mvnw.cmd spring-boot:run   # Windows PowerShell
# or
./mvnw spring-boot:run       # macOS/Linux
```

* App: [http://localhost:8080](http://localhost:8080)
* Main page: [http://localhost:8080/cats](http://localhost:8080/cats)

---

## Image Uploads

* Forms (`create` / `update`) include `enctype="multipart/form-data"` and `<input type="file" name="image">`
* Controller saves files to a local `uploads/` folder and sets `imageUrl` to `/images/<uuid>.ext`
* `WebConfig` maps `/images/**` → `uploads/` on disk

**Tip:** Ignore uploads in Git

```
# .gitignore
/uploads/
```

---

## Data Model (`BigCat`)

Fields: `bigCatId (PK)`, `name*`, `description*`, `commonName*`, `scientificName`,
`conservationStatus (EN|VU|NT|LC)`, `age*`, `habitat`, `weightKg`, `imageUrl`
(* required via validation)

---

## MVC Routes

| URL                 | View / Action           |
| ------------------- | ----------------------- |
| `/`                 | redirect to `/cats`      |
| `/cats`             | List (animal-list.ftlh) |
| `/cats/new`         | Create form             |
| `/cats/{id}`        | Details                 |
| `/cats/update/{id}` | Update form             |
| `/cats/delete/{id}` | Delete + redirect       |

---

## REST API (A3)

| Method | Endpoint                             | Description             |
| -----: | ------------------------------------ | ----------------------- |
|    GET | `/api/bigcats`                       | Get all big cats        |
|    GET | `/api/bigcats/{id}`                  | Get by ID               |
|   POST | `/api/bigcats`                       | Create                  |
|    PUT | `/api/bigcats/{id}`                  | Update                  |
| DELETE | `/api/bigcats/{id}`                  | Delete                  |
|    GET | `/api/bigcats/category/{commonName}` | Get by category/species |
|    GET | `/api/bigcats/search?name=abc`       | Search by partial name  |

**Example JSON (POST/PUT)**

```json
{
  "name": "Dave",
  "description": "Adult male tiger, calm and easy going.",
  "commonName": "Tiger",
  "scientificName": "Panthera tigris",
  "conservationStatus": "EN",
  "age": 5.0,
  "habitat": "North Carolina Zoo",
  "weightKg": 192.3
}
```

---

## Neon (PostgreSQL)

Useful queries for verification/demo:

```sql
SELECT * FROM public.big_cats ORDER BY big_cat_id DESC LIMIT 10;
SELECT COUNT(*) FROM public.big_cats;
SELECT DISTINCT conservation_status FROM public.big_cats;
```

---
