<script lang="ts">
  import '$lib/globals.scss';
  import favicon from '$lib/assets/favicon.svg';

  let { children } = $props();
</script>

<svelte:head>
  <link rel="icon" href={favicon} />
  <title>VOID&hearts;HEART &ndash; Hardcore survival Minecraft server</title>
</svelte:head>

{@render children?.()}
