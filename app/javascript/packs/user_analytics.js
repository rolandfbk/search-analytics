const user_analytics = async(user_id) => {
  const url = 'https://search-analytics-helpjuice.herokuapp.com/analytics/user_search?user_id='.concat(user_id);

  const request = new Request(url);

  const response = await fetch(request);
  const result = await response.json();

  return result;
};
  
const userSelect = document.getElementById('name');
userSelect.addEventListener('change', (e) => {
  const selectedUser = e.target.value;
  
  const userAnalytics = user_analytics(selectedUser);
  userAnalytics.then((data) => {
    if(data.analytics.length >= 0){
      const trendData = data.analytics;
      const analytics = document.getElementById('analytics');
      analytics.innerHTML = '';
      const trendTable = document.createElement('table');
      trendData.forEach((trend) => {
        const trendRow = document.createElement('tr');
        const trendName = document.createElement('td');
        const trendCount = document.createElement('td');
        trendName.innerHTML = trend[0];
        trendCount.innerHTML = '<i>' + trend[1] + ' count</i>';
        trendRow.appendChild(trendName);
        trendRow.appendChild(trendCount);
        trendTable.appendChild(trendRow);
        analytics.appendChild(trendTable);

        // console.log(trend[0] + ' ' + trend[1]);
      });
    } else {
      console.log('No data found');
    }
  });
});