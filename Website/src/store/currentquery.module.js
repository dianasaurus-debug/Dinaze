
const data = {query : null};

export const currentQuery = {
  namespaced: true,
  state: data,
  actions: {
    pickQuery({ commit }, query) {
      commit('insertQuery',query);
    },

  },
  mutations: {
    insertQuery(state, query) {
      state.query = query;
    }
  }
};
