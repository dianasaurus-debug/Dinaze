import axios from 'axios';
import authHeader from './auth-header';

const API_URL = 'https://wakaf.praditya.web.id/api/wakif-auth/';

class AuthService {
    login(user) {
        return axios
            .post(API_URL + 'login', {
                email: user.email,
                password: user.password
            })
            .then(response => {
                if (response.data.accessToken) {
                    localStorage.setItem('user', JSON.stringify(response.data));
                }

                return response.data;
            });
    }

    logout() {
        localStorage.removeItem('user');
    }

    register(user) {
        return axios.post(API_URL + 'register', {
            nama: user.nama,
            email: user.email,
            password: user.password,
            // nomor_ktp : user.nomor_ktp,
            // nomor_telepon : user.nomor_telepon,
            // alamat : user.alamat

        });
    }
    update(user) {
        return axios.put(API_URL + 'update/', {
            nama: user.nama,
            email: user.email,
            nik : user.nik,
            nomor_ponsel : user.nomor_ponsel,
            alamat : user.alamat
        },{ headers: authHeader() });
    }
    getProfile(){
        return axios.get(API_URL + 'get-wakif-data', { headers: authHeader() });
    }
    updateFoto(foto){
        return axios.put(API_URL + 'upload-photo' , foto,{headers: authHeader()});
    }
}

export default new AuthService();
