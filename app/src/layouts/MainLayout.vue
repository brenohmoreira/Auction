<template>
        <q-layout view="hHh Lpr lFf">
                <q-header class="bg-white text-dark">
                        <HeaderComponent/>
                </q-header>

                <q-drawer :model-value="true" side="left" :width="300" :breakpoint="0" class="border-r border-r-gray-300">
                        <div class="column justify-between h-full">
                                <div class="q-pa-lg column gap-3">
                                        <span class="text-caption font-medium text-gray-500 cursor-pointer" @click="router.push({ name: 'home' })"> Início </span>
                                </div>

                                <div class="column">
                                        <div class="q-pa-lg column gap-3">
                                                <div class="flex gap-3 cursor-pointer" @click="sair">
                                                        <IconLogout class="text-gray-500" size="18px"/>
                                                        <span class="text-caption font-medium text-gray-500"> Sair </span>
                                                </div>
                                        </div>

                                        <div class="flex items-start gap-3 q-pa-lg border-t border-t-gray-300">
                                                <div class="rounded-full bg-primary text-white font-bold py-2 px-2.5">
                                                        {{ usuario?.nome?.substring(0, 2).toUpperCase() }}
                                                </div>

                                                <div class="column">
                                                        <span class="overflow-hidden whitespace-nowrap text-ellipsis text-caption"> {{ usuario?.nome }} </span>
                                                        <span class="text-caption text-zinc-500"> {{ usuario?.email }}</span>
                                                </div>
                                        </div>
                                </div>
                        </div>
                </q-drawer>

                <q-page-container>
                        <router-view/>
                </q-page-container>
        </q-layout>
</template>

<script setup lang="ts">
import HeaderComponent from '@/components/Header/HeaderComponent.vue';
import { useAutenticacaoStore } from '@/stores/autenticacao';
import { IconLogout } from '@tabler/icons-vue';
import { storeToRefs } from 'pinia';
import { useRouter } from 'vue-router';

const router = useRouter()
const autenticacao = useAutenticacaoStore()
const { usuario } = storeToRefs(autenticacao)

async function sair() {
        await autenticacao.desconectar()
        await router.push({ name: 'conectar' });
}
</script>
