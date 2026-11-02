<template>
        <q-layout view="hHh Lpr lFf" class="bg-[#0F1116] [--ecco-autofill-bg:#0F1116] [--ecco-autofill-text:#fff]">
                <q-page-container>
                        <AppHeader/>
                        <div>
                                <router-view/>
                        </div>
                </q-page-container>
        </q-layout>
</template>

<script setup lang="ts">
        import AppHeader from '@/components/Header/AppHeader.vue';
</script>
