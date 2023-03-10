const save_search = async(userSearch) => {
  const url = 'http://localhost:3000/analytics';

  const myHeaders = new Headers();
  myHeaders.append('Content-Type', 'application/json');

  const raw = JSON.stringify({
    usersearch: userSearch,
  });

  const requestOptions = {
    method: 'POST',
    headers: myHeaders,
    body: raw,
    redirect: 'follow',
  };

  const response = await fetch(url, requestOptions);
  const myResult = await response.text();
  const finalResponse = JSON.parse(myResult);

  return finalResponse;
};

let search = [];
const searchForm = document.getElementById('search-form');
const searchText = document.getElementById('search-text');
const searchQuery = document.getElementById('search-query');

searchText.addEventListener('click', () => {
  searchQuery.innerHTML = '';
  document.getElementById('notification').innerHTML = '';
});

searchText.addEventListener('keyup', () => {
  const input = searchText.value;
  search.push(input);

  if(searchText.value.length > 0){
    searchQuery.innerHTML = ''.concat('Search Query: ', input);
  } else {
    searchQuery.innerHTML = '';
  }
});

searchForm.addEventListener('submit', (e) => {
  e.preventDefault();
  const userSearch = search.slice(-1)[0];
  const saveSearch = save_search(userSearch.trim());
  saveSearch.then((data) => {
    // console.log(data);
    if(data.answer){
      searchForm.reset();
      document.getElementById('notification').innerHTML = "Your search was successfully saved.";
      document.getElementById('notification').style.color = "green";
    } else {
      document.getElementById('notification').innerHTML = "There was an error saving your search.";
      document.getElementById('notification').style.color = "red";
    }
  });

  
});