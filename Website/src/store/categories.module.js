
const category = {category_id : 0};

export const categoriesStore = {
    namespaced: true,
    state: category,
    actions: {
        pickCategory({ commit }, category_id) {
            commit('insertCategory',category_id);
        },

    },
    mutations: {
        insertCategory(state, category_id) {
            state.category_id = category_id;
        }
    }
};