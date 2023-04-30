<script lang="ts">
  import { useNavigate } from "svelte-navigator";
  import { fade, fly } from "svelte/transition";
  import type {
    Alert,
    CostPayload,
    InsertPayload,
    UpdatePayload,
    Response,
    TableData,
    DeletePayload,
  } from "../interfaces";

  const URL = "http://localhost:3000/api/";
  const nav = useNavigate();
  const tables: TableData[] = [
    { name: "department", pkey: ["D_ID"] },
    { name: "student", pkey: ["S_ID"] },
    { name: "instructor", pkey: ["I_ID"] },
    { name: "course", pkey: ["C_ID"] },
    { name: "takes", pkey: ["S_ID", "C_ID"] },
    { name: "assignment", pkey: ["A_ID"] },
  ];

  const parse = (data: any): Response => {
    return {
      headers: data.metaData,
      values: data.rows,
    } satisfies Response;
  };

  const fetchData = async (table: string) => {
    const response = await fetch(`${URL}tables/${table}`);
    const data = await response.json();

    const parsedData = parse(data);
    optionResponse = parsedData;
    return parsedData;
  };

  const showInsertDataModal = async () => {
    dialogType = "insert";
  };

  const insertData = async () => {
    if (dialogArr.length !== optionResponse.headers.length) {
      alert = {
        message: "All fields must be filled",
        visible: true,
        type: "alert-error",
      };
      nav(-1);
      return;
    }

    const payload: InsertPayload = {
      data: dialogArr,
    };

    const response = await fetch(`${URL}tables/${option.name}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    dialogArr = [];

    const data = await response.text();

    if (response.status === 200) {
      promise = fetchData(option.name);

      alert = {
        message: "Successfully inserted data",
        visible: true,
        type: "alert-success",
      };
    } else {
      alert = {
        message: "Failed to insert data",
        visible: true,
        type: "alert-error",
      };
    }

    nav(-1);
  };

  const showUpdateDataModal = async (index: number) => {
    dialogArr = [...optionResponse.values[index]];
    dialogType = "update";
    currentUpdateIndex = index;
  };

  const updateData = async () => {
    if (dialogArr.length !== optionResponse.headers.length) {
      alert = {
        message: "All fields must be filled",
        visible: true,
        type: "alert-error",
      };
      nav(-1);
      return;
    }

    const payload: UpdatePayload = {
      data: dialogArr,
      pkey: option.pkey,
      pkeyData: optionResponse.values[currentUpdateIndex].filter(
        (_, i) => i === option.pkey.length - 1 || i === option.pkey.length - 2
      ),
      headers: optionResponse.headers.map((e) => e.name),
    };

    const response = await fetch(`${URL}tables/${option.name}`, {
      method: "PATCH",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    dialogArr = [];

    const data = await response.text();

    if (response.status === 200) {
      promise = fetchData(option.name);

      alert = {
        message: "Successfully updated data",
        visible: true,
        type: "alert-success",
      };
    } else {
      alert = {
        message: "Failed to update data",
        visible: true,
        type: "alert-error",
      };
    }

    nav(-1);
  };

  const deleteData = async (index: number) => {
    const payload: DeletePayload = {
      pkey: option.pkey,
      pkeyData: optionResponse.values[index].filter(
        (_, i) => i === option.pkey.length - 1 || i === option.pkey.length - 2
      ),
    };

    const response = await fetch(`${URL}tables/${option.name}`, {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });

    const data = await response.text();

    if (response.status === 200) {
      promise = fetchData(option.name);

      alert = {
        message: "Successfully updated data",
        visible: true,
        type: "alert-success",
      };
    } else {
      alert = {
        message: "Failed to update data",
        visible: true,
        type: "alert-error",
      };
    }
  };

  let option: TableData = tables[0];
  let optionResponse: Response = { headers: [], values: [] };
  let dialogArr: string[] = [];
  let dialogType: "update" | "insert";
  let currentUpdateIndex: number;

  let alert: Alert = { message: "", visible: false, type: "alert-success" };
  $: {
    setTimeout(() => {
      alert = { ...alert, visible: false };
    }, 5000);
  }

  let costData: CostPayload = { vehicleData: [], total: 0 };

  let promise = fetchData("driver");
  $: promise = fetchData(option.name);
</script>

<div class="flex flex-col w-screen h-screen">
  <div class="navbar bg-base-100">
    <div class="flex-1">
      <select
        bind:value={option}
        class="w-full max-w-xs select select-bordered"
      >
        {#each tables as item}
          <option value={item}>{item.name}</option>
        {/each}
      </select>
    </div>
    <div class="flex-none">
      <ul class="gap-3 px-1 menu menu-horizontal">
        <a
          on:click={() => showInsertDataModal()}
          href="#upsert-modal"
          class="btn">New record</a
        >
      </ul>
    </div>
  </div>
  <div class="h-full overflow-x-auto">
    {#await promise}
      <div class="flex items-center justify-center h-full">
        <h1 class="text-5xl">Loading</h1>
      </div>
    {:then data}
      <table class="table w-full">
        <thead>
          <tr>
            <th />
            <th />
            {#each data.headers as item}
              <th>{item.name}</th>
            {/each}
          </tr>
        </thead>
        <tbody>
          {#each data.values as item, i}
            <tr class="hover">
              <td>
                <a
                  on:click={() => showUpdateDataModal(i)}
                  href="#upsert-modal"
                  class="btn">Update</a
                >
              </td>
              <td>
                <button on:click={() => deleteData(i)} class="btn"
                  >Delete</button
                >
              </td>
              {#each item as item}
                <td>{item}</td>
              {/each}
            </tr>
          {/each}
        </tbody>
      </table>
    {:catch error}
      <div class="flex items-center justify-center h-full">
        <h1 class="text-5xl">{error}</h1>
      </div>
    {/await}
  </div>
</div>

<div class="modal" id="upsert-modal">
  <div class="modal-box">
    <h3 class="text-lg font-bold">Insert into {option.name.toUpperCase()}</h3>
    <ul class="flex flex-col gap-2 my-5">
      {#each optionResponse.headers as item, i}
        <input
          bind:value={dialogArr[i]}
          class="w-full input input-bordered"
          type="text"
          placeholder={item.name}
        />
      {/each}
    </ul>
    <div class="modal-action">
      <button
        on:click={async () =>
          dialogType === "insert" ? await insertData() : await updateData()}
        class="btn">Submit</button
      >
      <a href="#" class="btn">Close</a>
    </div>
  </div>
</div>

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
          class="flex-shrink-0 w-6 h-6 stroke-current"
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
