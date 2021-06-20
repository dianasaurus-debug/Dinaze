import axios from 'axios';
import authHeader from './auth-header-admin.service';

const API_URL = 'http://localhost:4000/api/';

class AdminService {
    getAdminBoard() {
        return axios.get(API_URL + 'admin/index', { headers: authHeader() });
    }
}

export default new AdminService();
