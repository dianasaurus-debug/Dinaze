import AuthService from '../services/auth.service';

const user = JSON.parse(localStorage.getItem('user'));
const initialState = user
    ? { status: { loggedIn: true }, user }
    : { status: { loggedIn: false }, user: null };

export const auth = {
    namespaced: true,
    state: initialState,
    actions: {
        login({ commit }, user) {
            return AuthService.login(user).then(
                user => {
                    AuthService.getProfile().then(
                      userResult => {
                          commit('getProfileSuccess', userResult);
                          return Promise.resolve(userResult);
                      }
                    )
                },
                error => {
                    commit('loginFailure');
                    return Promise.reject(error);
                }
            );
        },
        loginGmail({ commit }, user) {
            return AuthService.loginGmail(user).then(
                user => {
                    AuthService.getProfile().then(
                        userResult => {
                            commit('getProfileSuccess', userResult);
                            return Promise.resolve(userResult);
                        }
                    )
                },
                error => {
                    commit('loginFailure');
                    return Promise.reject(error);
                }
            );
        },
        logout({ commit }) {
            AuthService.logout();
            commit('logout');
        },
        register({ commit }, user) {
            return AuthService.register(user).then(
                userResult => {
                    commit('getProfileSuccess', userResult);
                    return Promise.resolve(userResult);
                },
                error => {
                    commit('registerFailure');
                    return Promise.reject(error);
                }
            );
        },
        registerGmail({ commit }, user) {
            return AuthService.registerGmail(user).then(
                response => {
                    commit('registerSuccessGmail');
                    return Promise.resolve(response.data);
                },
                error => {
                    commit('registerFailure');
                    return Promise.reject(error);
                }
            );
        },
        update({ commit }, user) {
            return AuthService.update(user).then(
              response => {
                  AuthService.getProfile().then(
                    userResult => {
                        commit('getProfileSuccess', userResult);
                        return Promise.resolve(userResult);
                    }
                  )
              }
            );
        },
        updateFoto({ commit }, foto) {
          return AuthService.updateFoto(foto).then(
            response => {
              AuthService.getProfile().then(
                userResult => {
                  commit('getProfileSuccess', userResult);
                  return Promise.resolve(userResult);
                }
              )
            }
          );
        }
    },
    mutations: {
        loginSuccess(state, user) {
            state.status.loggedIn = true;
            state.user = user;
        },
        updateSuccess(state, user) {
            state.user = user;
        },
        getProfileSuccess(state, user){
          state.status.loggedIn = true;
          state.user = user;
        },
        loginFailure(state) {
            state.status.loggedIn = false;
            state.user = null;
        },
        logout(state) {
            state.status.loggedIn = false;
            state.user = null;
        },
        registerSuccess(state) {
            state.status.loggedIn = false;
        },
        registerSuccessGmail(state) {
            state.status.loggedIn = true;
        },
        registerFailure(state) {
            state.status.loggedIn = false;
        }
    }
};
