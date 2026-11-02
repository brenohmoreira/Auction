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
                                <label for="cadastro-nome" class="mb-1 text-white font-mono text-[11px] uppercase tracking-widest"> Nome </label>
                                <q-input v-model="nome" tabindex="1" for="cadastro-nome" autofocus type="text" maxlength="100" autocomplete="name" outlined dense dark input-class="text-caption"/>

                                <label for="cadastro-email" class="mb-1 text-white mt-3 font-mono text-[11px] uppercase tracking-widest"> E-mail </label>
                                <q-input v-model="email" tabindex="2" for="cadastro-email" type="email" maxlength="254" autocomplete="email" outlined dense dark input-class="text-caption"/>

                                <label for="cadastro-password" class="mb-1 text-white mt-3 font-mono text-[11px] uppercase tracking-widest"> Senha </label>
                                <q-input v-model="senha" tabindex="3" for="cadastro-password" maxlength="128" :type="mostrarSenha ? 'text' : 'password'" autocomplete="new-password" outlined dense dark input-class="text-caption">
                                        <template #append>
                                                <q-btn flat round dense size="xs" tabindex="-1" class="text-gray-400" :icon="mostrarSenha ? 'visibility_off' : 'visibility'" :aria-label="mostrarSenha ? 'Ocultar senha' : 'Mostrar senha'" @click="mostrarSenha = !mostrarSenha"/>
                                        </template>
                                </q-input>

                                <label for="cadastro-confirma-password" class="mb-1 text-white mt-3 font-mono text-[11px] uppercase tracking-widest"> Confirmar senha </label>
                                <q-input v-model="confirmaSenha" tabindex="4" for="cadastro-confirma-password" maxlength="128" :type="mostrarConfirmaSenha ? 'text' : 'password'" autocomplete="new-password" outlined dense dark input-class="text-caption">
                                        <template #append>
                                                <q-btn flat round dense size="xs" tabindex="-1" class="text-gray-400" :icon="mostrarConfirmaSenha ? 'visibility_off' : 'visibility'" :aria-label="mostrarConfirmaSenha ? 'Ocultar senha' : 'Mostrar senha'" @click="mostrarConfirmaSenha = !mostrarConfirmaSenha"/>
                                        </template>
                                </q-input>

                                <q-btn :loading="carregando" tabindex="5" type="submit" label="Cadastrar" color="primary" text-color="white" unelevated no-caps class="mt-10 h-10 w-full text-caption font-semibold"/>
                        </q-form>

                        <p class="mt-4 text-center text-[13px] text-gray-400">
                                Já possui uma conta?
                                <router-link :to="{ name: 'conectar' }" tabindex="6" class="text-primary font-medium no-underline hover:underline">
                                        Conecte-se
                                </router-link>
                        </p>
                </div>
        </q-page>
</template>

<script setup lang="ts">
        import { ref } from 'vue';
        import { useRouter } from 'vue-router';
        import { Notify } from 'quasar';
        import { http } from '@/services/http';

        const email = ref('');
        const senha = ref('');
        const confirmaSenha = ref('');
        const nome = ref('');
        const mostrarSenha = ref(false);
        const mostrarConfirmaSenha = ref(false);
        const carregando = ref(false);
        const router = useRouter();

        function erro(mensagem: string) {
                Notify.create({
                        type: 'negative',
                        message: mensagem,
                })
        }

        const REGEX_EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const REGEX_SENHA = /^\S+$/;
        const MIN_SENHA = 8;
        const MAX_SENHA = 128;
        const MAX_EMAIL = 254;
        const MAX_NOME = 100;

        function validaDados(): boolean {
                if (senha.value.trim() === '') {
                        erro("Digite uma senha antes de prosseguir")
                        return false
                }

                if (!REGEX_SENHA.test(senha.value)) {
                        erro("A senha não pode conter espaços")
                        return false
                }

                if (senha.value.length < MIN_SENHA || senha.value.length > MAX_SENHA) {
                        erro(`A senha deve ter entre ${MIN_SENHA} e ${MAX_SENHA} caracteres`)
                        return false
                }

                if (senha.value !== confirmaSenha.value) {
                        erro("As senhas digitadas não coincidem")
                        return false
                }

                if (!REGEX_EMAIL.test(email.value.trim()) || email.value.trim().length > MAX_EMAIL) {
                        erro("Digite um e-mail válido")
                        return false
                }

                if (nome.value.trim() === '' || nome.value.trim().length > MAX_NOME) {
                        erro(`Digite um nome de até ${MAX_NOME} caracteres`)
                        return false
                }

                return true
        }

        async function aoClicar() {
                if (!validaDados()) return

                carregando.value = true

                try {
                        await http.post('/autenticacao/cadastro', { email: email.value, nome: nome.value.trim(), senha: senha.value })
                        Notify.create({ type: 'positive', message: 'Cadastrado com sucesso. Conecte-se para prosseguir'})
                        await router.push({ name: 'conectar' })
                }
                finally {
                        carregando.value = false
                }
        }
</script>
