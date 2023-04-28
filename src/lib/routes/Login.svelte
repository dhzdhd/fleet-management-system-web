<script lang="ts">
  import { useFocus, useNavigate } from "svelte-navigator";
  import { fade, fly } from "svelte/transition";
  import type { Alert } from "../interfaces";

  const nav = useNavigate();

  let username: string;
  let password: string;

  const submit = () => {
    if (password === "a" && username === "a") {
      nav("home");
    } else {
      alert = {
        message: "Wrong credentials",
        visible: true,
        type: "alert-error",
      };
    }
  };

  let alert: Alert = { message: "", visible: false, type: "alert-success" };
  $: {
    setTimeout(() => {
      alert = { ...alert, visible: false };
    }, 5000);
  }
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

{#key alert.visible}
  <div
    in:fly={{ y: 200 }}
    out:fade
    class={`${
      alert.visible ? "visible" : "invisible"
    } w-screen fixed bottom-5 flex justify-center`}
  >
    <div class={`w-[90vw] alert ${alert.type} shadow-lg`}>
      <div>
        <svg
          xmlns="http://www.w3.org/2000/svg"
          class="stroke-current flex-shrink-0 h-6 w-6"
          fill="none"
          viewBox="0 0 24 24"
          ><path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
          /></svg
        >
        <span>{alert.message}</span>
      </div>
    </div>
  </div>
{/key}
