<script lang="ts">
  import { useFocus, useNavigate } from "svelte-navigator";

  let username: string;
  let password: string;

  const submit = () => {
    if (password === "a" && username === "a") {
      const nav = useNavigate();
      nav("home");
    }
  };
</script>

<form
  class="h-screen flex flex-col items-center justify-center gap-5"
  action=""
>
  <input
    bind:value={username}
    class="input input-bordered w-full max-w-xs"
    type="text"
    placeholder="Username"
  />
  <input
    bind:value={password}
    class="input input-bordered w-full max-w-xs"
    type="text"
    placeholder="Password"
  />
  <button on:click|preventDefault={submit} class="mt-10 btn btn-accent"
    >Submit</button
  >
</form>
