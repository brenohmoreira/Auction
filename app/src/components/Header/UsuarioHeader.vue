<template>
        <div v-if="usuario" class="flex items-center gap-3">
                <!-- Avatar: iniciais na Big Shoulders (destaque) -->
                <span class="grid place-items-center size-11 bg-primary text-white font-display font-black text-[20px] leading-none" aria-hidden="true">
                        {{ iniciais }}
                </span>

                <!-- Nome na Schibsted (leitura), e-mail na Plex Mono (dado) -->
                <div class="column leading-tight max-w-50">
                        <span class="text-white font-semibold text-[15px] truncate"> {{ usuario.nome }} </span>
                        <span class="text-gray-400 font-mono text-[12px] truncate"> {{ usuario.email }} </span>
                </div>

                <q-btn :loading="saindo" flat no-caps label="Sair" class="ml-2 h-9 px-3 border border-[#2A2E37] hover:border-white text-white font-mono text-[11px] uppercase tracking-[0.12em] transition-colors duration-300" @click="sair"/>
        </div>

        <!-- Sem login (a home é pública): mesmo botão, levando para o login -->
        <q-btn v-else flat no-caps label="Entrar" :to="{ name: 'conectar' }" class="h-9 px-3 border border-[#2A2E37] hover:border-white text-white font-mono text-[11px] uppercase tracking-[0.12em] transition-colors duration-300"/>
</template>

<script setup lang="ts">
        import { computed, ref } from 'vue';
        import { storeToRefs } from 'pinia';
        import { useRouter } from 'vue-router';
        import { useAutenticacaoStore } from '@/stores/autenticacao';

        const autenticacao = useAutenticacaoStore();
        const { usuario } = storeToRefs(autenticacao);
        const router = useRouter();
        const saindo = ref(false);

        // "Breno Silva" → "BS"; "Breno" → "BR"
        const iniciais = computed(() => {
                const partes = (usuario.value?.nome ?? '').trim().split(/\s+/).filter(Boolean);
                if (partes.length === 0) return '';
                const texto = partes.length > 1 ? partes[0]![0]! + partes[partes.length - 1]![0]! : partes[0]!.slice(0, 2);
                return texto.toUpperCase();
        });

        async function sair() {
                saindo.value = true;

                try {
                        await autenticacao.desconectar();
                        await router.push({ name: 'conectar' });
                }
                finally {
                        saindo.value = false;
                }
        }
</script>
