import axios from 'axios';

const API_URL = 'https://wakaf.praditya.web.id/api/admin-auth/';

class AuthAdminService {
    login(user) {
        return axios
            .post(API_URL + 'login', {
                email: user.email,
                password: user.password
            })
            .then(response => {
                if (response.data.accessToken) {
                    localStorage.setItem('admin', JSON.stringify(response.data));
                }
                return response.data;
            });
    }

    logout() {
        localStorage.removeItem('admin');
    }

    register(user) {
        return axios.post(API_URL + 'register', {
            nama: user.nama,
            email: user.email,
            password: user.password
        });
    }
}

export default new AuthAdminService();
