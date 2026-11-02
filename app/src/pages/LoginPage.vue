<template>
        <q-page class="flex items-center justify-center px-6 py-12 bg-[#0F1116] [--ecco-autofill-bg:#0F1116] [--ecco-autofill-text:#fff]">
                <div class="w-full max-w-75">
                        <div class="w-full flex items-center justify-start mb-3">
                                <div class="column">
                                        <span class="font-display text-primary font-extrabold text-[30px] uppercase leading-none tracking-wide"> Ecco </span>
                                        <span class="mt-1 text-sm text-gray-400"> Insira suas credenciais </span>
                                </div>
                        </div>

                        <q-form class="flex flex-col mt-5" @submit="aoClicar">
                                <label for="login-email" class="mb-1 text-white font-mono text-[11px] uppercase tracking-widest"> E-mail </label>
                                <q-input v-model="email" tabindex="1" for="login-email" autofocus type="email" maxlength="254" outlined dense dark input-class="text-caption"/>

                                <label for="login-password" class="mb-1 text-white mt-3 font-mono text-[11px] uppercase tracking-widest"> Senha </label>
                                <q-input v-model="senha" tabindex="2" for="login-password" maxlength="128" :type="mostrarSenha ? 'text' : 'password'" autocomplete="current-password" outlined dense dark input-class="text-caption">
                                        <template #append>
                                                <q-btn flat round dense size="xs" tabindex="-1" class="text-gray-400" :icon="mostrarSenha ? 'visibility_off' : 'visibility'" :aria-label="mostrarSenha ? 'Ocultar senha' : 'Mostrar senha'" @click="mostrarSenha = !mostrarSenha"/>
                                        </template>
                                </q-input>

                                <span class="text-primary text-[13px] font-medium block mt-3 cursor-pointer brightness-95 transition-all duration-300"> Esqueci minha senha </span>

                                <q-btn :loading="carregando" tabindex="3" type="submit" label="Entrar" color="primary" text-color="white" unelevated no-caps class="mt-5 rounded-none h-10 w-full text-caption font-semibold"/>
                        </q-form>

                        <p class="mt-4 text-center text-[13px] text-gray-400">
                                Não tem uma conta?
                                <router-link :to="{ name: 'cadastrar' }" tabindex="4" class="text-primary font-medium no-underline hover:underline">
                                        Criar conta
                                </router-link>
                        </p>
                </div>
        </q-page>
</template>

<script setup lang="ts">
        import { ref } from 'vue';
        import { useAutenticacaoStore } from '@/stores/autenticacao';
        import { useRoute, useRouter } from 'vue-router';

        const autenticacao = useAutenticacaoStore()
        const email = ref('');
        const senha = ref('');
        const mostrarSenha = ref(false);
        const carregando = ref(false) 
        const router = useRouter()
        const route = useRoute() 

        async function aoClicar() {
                carregando.value = true 

                try {
                        await autenticacao.entrar(email.value, senha.value)
                        const redireciopnar = typeof route.query.redirect === 'string' ? route.query.redirect : '/'
                        await router.push(redireciopnar)
                }
                finally {
                        carregando.value = false 
                }
        }
</script>
