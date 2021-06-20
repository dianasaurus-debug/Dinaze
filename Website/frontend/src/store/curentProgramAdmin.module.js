
const data = {program : null};

export const currentProgramAdmin = {
  namespaced: true,
  state: data,
  actions: {
    pickProgram({ commit }, program) {
      commit('insertProgram',program);
    },

  },
  mutations: {
    insertProgram(state, program) {
      state.program = program;
    }
  }
};
