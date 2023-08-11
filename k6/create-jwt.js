import http from 'k6/http';

// k6 run --vus 50 --duration 5s create-jwt.js

const url = 'http://localhost/token-auth/_j_security_check';

export default function () {

  const data = { 
    j_username: 'admin',  
    j_password: 'admin'
  };

  const params = {
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
  };

  http.post(url,data,params);

  // const res = http.post(url,data,params);
  // console.log(res.headers.Authorization);
}
