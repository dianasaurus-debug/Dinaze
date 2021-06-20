import axios from 'axios';
import authHeader from './auth-header';

const API_URL = 'http://localhost:4000/api/';

class UserService {
    getUserBoard() {
        return axios.get(API_URL + 'user/index', { headers: authHeader() });
    }
}

export default new UserService();
