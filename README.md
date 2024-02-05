To setup the project follow the steps

1. Cloning the Project: 
    git clone https://github.com/mdanixhali/product-feedback-and-comment.git

2. Navigate to the project directory:
    cd product-feedback-and-comment

3. Installing Laravel Dependencies:
    composer install

4. Generate an application key:
    php artisan key:generate

5. Installing Node.js and npm:
    Make sure you have Node.js and npm installed. You can download them from https://nodejs.org/.

6. Installing Vue.js, Vuex, and Vue Router:
    npm install (Review all dependencies in package.json)

7. Compiling Assets:
    npm run dev

8. Database or migration
    A file exists inside stoarage -> db -> .sql file

9. Env setup
    For the assisstance, .env file exists in the setup

10. Credential file exists inside stoarage -> credentials -> .txt file
11. After completeing the setup run the following command
    php artisan optimize:clear


How to use the system?
1. After login, you will see a navigation menu with two options:
    Add Feedback: Navigate to add feedback page.
    Feedback List: View the list of feedback entries.

2. Form Validation:

    All form entries are validated on the frontend to ensure a smooth user experience.
    Backend validation is in place to secure and validate data before processing.