<script lang="ts">
  import { useFocus, useNavigate } from "svelte-navigator";

  const nav = useNavigate();

  let username: string;
  let password: string;

  const submit = () => {
    if (password === "a" && username === "a") {
      nav("home");
    }
  };
</script>

<form
  class="flex flex-col items-center justify-center h-screen gap-5"
  action=""
>
  <input
    bind:value={username}
    class="w-full max-w-xs input input-bordered"
    type="text"
    placeholder="Username"
  />
  <input
    bind:value={password}
    class="w-full max-w-xs input input-bordered"
    type="text"
    placeholder="Password"
  />
  <button on:click|preventDefault={submit} class="mt-10 btn btn-accent"
    >Submit</button
  >
</form>
