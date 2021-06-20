import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import { auth } from './auth.module';
import { auth_admin } from './auth-admin.module';
import { categoriesStore } from './categories.module';
import { currentProgram } from './currentProgram.module';
import { currentProgramAdmin } from './curentProgramAdmin.module';
import { currentQuery } from '@/store/currentquery.module'

Vue.use(Vuex);

export default new Vuex.Store({
    modules: {
        auth,
        auth_admin,
        categoriesStore,
        currentProgram,
        currentProgramAdmin,
        currentQuery
    },
    plugins: [createPersistedState()]
});
