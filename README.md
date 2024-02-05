## System Requirements
    - PHP: 8.1.10
    - Laravel:  10.42.0
    - Vue: 3.4.0
    - Node: 18.8.0

## To setup the project follow the steps

1. **Cloning the Project:** 
    - git clone https://github.com/mdanixhali/product-feedback-and-comment.git

2.** Navigate to the project directory:**
    - cd product-feedback-and-comment

3. **Installing Laravel Dependencies:**
    - composer install

4. **Generate an application key:**
    - php artisan key:generate

5. **Installing Node.js and npm:**
    - Make sure you have Node.js and npm installed. You can download them from https://nodejs.org/.

6. **Installing Vue.js, Vuex, and Vue Router:**
    - npm install (Review all dependencies in package.json)

7. **Compiling Assets:**
    - npm run dev

8. **Database or migration:**
    - A file exists inside storage -> db -> .sql file

9. **Env setup:**
    - For the assistance, the .env file exists in the setup

10. Credential file exists inside storage -> credentials -> .txt file
11. After completing the setup run the following command
    php artisan optimize:clear

## How to use the system?
1. After login, you will see a navigation menu with two options:

    **Add Feedback:** Navigate to the Add Feedback page.
    **Feedback List:** View the list of feedback entries.

3. **Form Validation:**
    All form entries are validated on the front-end to ensure a smooth user experience.
    Backend validation is in place to secure and validate data before processing.
4. **Listing Page Functionalities:**
   - **Backend Pagination:** Feedback entries are paginated on the backend for efficient data retrieval and presentation.
   - **Delete Feedback Option:**
     - Each feedback entry has an option to delete it.
     - Clicking on the delete option will prompt the user for confirmation before permanently removing the feedback entry.
   - **View Comment Option:**
     - Clicking on the "View Comment" option redirects the user to another route to view detailed information about the selected feedback entry and its related comments.

5. **View Comment Page Functionalities:**
   - **Delete Feedback and Related Comments:**
     - On this page, there is an option to delete the feedback and all its related comments.
     - A confirmation prompt will appear before the deletion is finalized.

   - **View All Comments for the Feedback:**
     - Users can view all comments associated with the selected feedback entry.

   - **Add/Edit Comment:**
     - Users have the option to add a new comment.
     - Additionally, they can edit an existing comment.

   - **Formatting Shortcuts:** Use keyboard shortcuts for formatting comments
     - **Bold:** `Ctrl + B`
     - **Italic:** `Ctrl + I`
     - **Underline:** `Ctrl + U`
     - **Code Block:** `Ctrl + Shift + K`
    
 - **Mentioning Users:**
     - To mention a user in a comment, use `@` followed by the user's username characters.

   
