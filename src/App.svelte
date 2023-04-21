<script lang="ts">
  async function fet() {
    const res = await fetch('http://localhost:3000/api');
    return await res.text();
  }
</script>

<main>
  {#await fet()}
    <p>load</p>
  {:then data}
    <p>{data}</p>
  {/await}
</main>
