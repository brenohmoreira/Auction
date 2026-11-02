<template>
        <header>
                <div class="w-[90%] mx-auto py-4 flex items-center justify-between gap-6">
                        <div class="flex gap-8 items-center">
                                <router-link :to="{ name: 'home' }" class="font-display text-primary font-extrabold text-[40px] uppercase leading-none tracking-wide no-underline" aria-label="Ecco, início"> Ecco </router-link>

                                <nav class="flex text-white gap-3 font-bold tracking-wide">
                                        <span class="text-caption cursor-pointer hover:brightness-90 transition-all duration-300"> INICIO </span>
                                        <span class="text-caption cursor-pointer hover:brightness-90 transition-all duration-300"> LEILÕES </span>
                                        <span class="text-caption cursor-pointer hover:brightness-90 transition-all duration-300"> MEUS LEILÕES </span>
                                        <span class="text-caption cursor-pointer hover:brightness-90 transition-all duration-300"> ARREMATES </span>
                                </nav>
                        </div>

                        <UsuarioHeader/>
                </div>
        </header>
</template>

<script setup lang="ts">
        import UsuarioHeader from './UsuarioHeader.vue';
</script>
