# animal-api-tedwards
RESTful API for my animal website CSC 340 Assignment 3
by William Taylor Edwards
## Demo
Click below to view the demo video:  
[Big Cats API Demo (OneDrive)](https://uncg-my.sharepoint.com/:v:/g/personal/wtedwards_uncg_edu/ESJAQFAC7TVDjrUZhhG4KC0B69lQKL8VLmnpweVQIAMNJg?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=oQbest)

## Installation

1. Clone this repository:  
   ```bash
   git clone https://github.com/WTedwards-Work/animal-api-tedwards.git
   cd animal-api-tedwards
   ```

2. Make sure you have Java 17 and Maven installed.

3. Configure your application.properties file:  
   ```properties
   spring.datasource.url=jdbc:postgresql://ep-summer-hill-ad0fdvon-pooler.c-2.us-east-1.aws.neon.tech/neondb?sslmode=require
   spring.datasource.username=neondb_owner
   spring.datasource.password=your_password_here
   spring.jpa.hibernate.ddl-auto=update
   spring.jpa.show-sql=true
   ```

4. Run the application:  
   ```bash
   ./mvnw spring-boot:run
   ```

5. The API will start on http://localhost:8080

-----------------------------------------------------------------------------------------------------------

## Endpoints

|  Method |   Endpoint   |   Description   |
|---------|--------------------------------------|--------------------------------------------------------|
| GET     | /api/bigcats                         | Retrieve all big cats |
| GET     | /api/bigcats/{id}                    | Retrieve a big cat by its ID |
| POST    | /api/bigcats                         | Add a new big cat     |
| PUT     | /api/bigcats/{id}                    | Update an existing big cat |
| DELETE  | /api/bigcats/{id}                    | Delete a big cat by ID |
| GET     | /api/bigcats/category/{commonName}   | Retrieve all big cats by category (e.g., species) |
| GET     | /api/bigcats/search?name={substring} | Search for big cats by partial name |

----------------------------------------------------------------------------------------------------------

## Example JSON (for POST / PUT requests)
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
`````````````````````````````````````````````````````````````````````````````````````````````````````````

## Technologies Used
- Java 17
- Spring Boot 3.5.6
- Spring Data JPA
- PostgreSQL (NeonDB)
- Thunder Client (for API testing)
