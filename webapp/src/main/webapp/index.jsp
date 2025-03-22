<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Github Profiles</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500&display=swap"
      rel="stylesheet"
    />
    <style>
      /* Universal Styles */
      * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
      }
      body {
        background-color: #2a2a72;
        color: #fff;
        font-family: 'Poppins', sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
      }

      /* Form Section */
      .user-form {
        width: 90%;
        max-width: 600px;
        margin-bottom: 2rem;
      }
      .user-form input {
        width: 100%;
        padding: 0.8rem;
        border: none;
        border-radius: 8px;
        background-color: #4c2885;
        color: #fff;
        font-size: 1rem;
        box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
        transition: background-color 0.3s ease-in-out;
      }
      .user-form input:focus {
        outline: none;
        background-color: #5a3392;
      }
      .user-form input::placeholder {
        color: #bbb;
      }

      /* Card Section */
      .card {
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: #4c2885;
        border-radius: 15px;
        padding: 2rem;
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        max-width: 700px;
        width: 90%;
        margin: auto;
      }
      .avatar {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        border: 5px solid #2a2a72;
      }
      .user-info {
        text-align: center;
        margin-top: 1rem;
      }
      .user-info h2 {
        margin-bottom: 0.5rem;
      }
      .user-info ul {
        list-style-type: none;
        padding: 0;
        display: flex;
        justify-content: space-around;
        margin: 1rem 0;
      }
      .user-info ul li {
        text-align: center;
      }
      .repo {
        text-decoration: none;
        color: #fff;
        background-color: #212a72;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        margin: 0.5rem;
        transition: background-color 0.3s ease-in-out;
      }
      .repo:hover {
        background-color: #2e3a92;
      }

      /* Error Card */
      .card h1 {
        text-align: center;
        color: #ff6b6b;
        font-size: 1.5rem;
      }

      /* Responsive Design */
      @media (max-width: 768px) {
        .card {
          padding: 1.5rem;
        }
        .user-info ul {
          flex-direction: column;
        }
        .user-info ul li {
          margin-bottom: 0.5rem;
        }
      }
    </style>
  </head>
  <body>
    <form class="user-form" id="form">
      <input type="text" id="search" placeholder="Find a Github User" />
    </form>
    <main id="main"></main>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.0/axios.min.js"></script>
    <script>
      const APIURL = 'https://api.github.com/users/';
      const main = document.getElementById('main');
      const form = document.getElementById('form');
      const search = document.getElementById('search');

      async function getUser(username) {
        try {
          const { data } = await axios(APIURL + username);
          createUserCard(data);
          getRepos(username);
        } catch (err) {
          if (err.response.status === 404) {
            createErrorCard('No profile with this username.');
          }
        }
      }

      async function getRepos(username) {
        try {
          const { data } = await axios(`${APIURL}${username}/repos?sort=created`);
          addReposToCard(data);
        } catch (err) {
          createErrorCard('Problem fetching repositories.');
        }
      }

      function createUserCard(user) {
        const userID = user.name || user.login;
        const userBio = user.bio ? `<p>${user.bio}</p>` : '';
        const cardHTML = `
          <div class="card">
            <img src="${user.avatar_url}" alt="${user.name}" class="avatar" />
            <div class="user-info">
              <h2>${userID}</h2>
              ${userBio}
              <ul>
                <li><strong>${user.followers}</strong> Followers</li>
                <li><strong>${user.following}</strong> Following</li>
                <li><strong>${user.public_repos}</strong> Repositories</li>
              </ul>
              <div id="repos"></div>
            </div>
          </div>`;
        main.innerHTML = cardHTML;
      }

      function createErrorCard(message) {
        const cardHTML = `
          <div class="card">
            <h1>${message}</h1>
          </div>`;
        main.innerHTML = cardHTML;
      }

      function addReposToCard(repos) {
        const reposEl = document.getElementById('repos');
        repos
          .slice(0, 5)
          .forEach((repo) => {
            const repoEl = document.createElement('a');
            repoEl.classList.add('repo');
            repoEl.href = repo.html_url;
            repoEl.target = '_blank';
            repoEl.innerText = repo.name;
            reposEl.appendChild(repoEl);
          });
      }

      form.addEventListener('submit', (e) => {
        e.preventDefault();
        const user = search.value.trim();
        if (user) {
          getUser(user);
          search.value = '';
        }
      });
    </script>
  </body>
</html>
