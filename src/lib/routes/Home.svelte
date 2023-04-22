<script lang="ts">
  import { useNavigate } from "svelte-navigator";

  interface TableData {
    name: string;
    pkey: string[];
    recordCount: number;
  }

  interface Response {
    headers: { name: string }[];
    values: string[][];
  }

  interface InsertPayload {
    data: string[];
  }

  interface UpdatePayload extends InsertPayload {
    pkey: string[];
    pkeyData: string[];
  }

  const URL = "http://localhost:3000/api/tables/";
  const nav = useNavigate();
  const tables: TableData[] = [
    { name: "driver", pkey: [], recordCount: 0 },
    { name: "vehicle", pkey: [], recordCount: 0 },
    { name: "trip", pkey: [], recordCount: 0 },
    { name: "cost", pkey: [], recordCount: 0 },
    { name: "vehicle_involved", pkey: [], recordCount: 0 },
    { name: "driver_involved", pkey: [], recordCount: 0 },
    { name: "driver_phone", pkey: [], recordCount: 0 },
  ];

  const parse = (data: any): Response => {
    return {
      headers: data.metaData,
      values: data.rows,
    } satisfies Response;
  };

  const fetchData = async (table: string) => {
    const response = await fetch(`${URL}${table}`);
    const data = await response.json();

    const parsedData = parse(data);
    optionResponse = parsedData;
    return parsedData;
  };

  const insertData = async () => {
    if (dialogArr.length !== optionResponse.headers.length) {
      nav(-1);
      return;
    }

    const payload: InsertPayload = {
      data: dialogArr,
    };

    const response = await fetch(`${URL}${option.name}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    dialogArr = [];

    const data = await response.text();
    console.log(data);

    nav(-1);
  };

  const showUpdateDataModal = async (index: number) => {
    dialogArr = optionResponse.values[index];
  };

  const updateData = async (index: number) => {
    if (dialogArr.length !== optionResponse.headers.length) {
      nav(-1);
      return;
    }

    const payload: UpdatePayload = {
      data: dialogArr,
      pkey: option.pkey,
      pkeyData: option.pkey.map(
        (attr) =>
          optionResponse.values[index][
            optionResponse.headers.indexOf({ name: attr })
          ]
      ),
    };

    const response = await fetch(`${URL}${option.name}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(payload),
    });
    dialogArr = [];

    const data = await response.text();
    console.log(data);

    nav(-1);
  };

  let option: TableData = tables[0];
  let optionResponse: Response = { headers: [], values: [] };
  let dialogArr: string[] = [];

  let promise = fetchData("driver");
  $: promise = fetchData(option.name);
</script>

<div class="h-screen w-screen flex flex-col">
  <div class="navbar bg-base-100">
    <div class="flex-1">
      <select
        bind:value={option}
        class="select select-bordered w-full max-w-xs"
      >
        {#each tables as item}
          <option value={item}>{item.name}</option>
        {/each}
      </select>
    </div>
    <div class="flex-none">
      <ul class="menu menu-horizontal px-1">
        <a href="#upsert-modal" class="btn">New record</a>
      </ul>
    </div>
  </div>
  <div class="overflow-x-auto">
    {#await promise}
      <div>Loading</div>
    {:then data}
      <table class="table w-full outline-2 outline-accent outline">
        <thead>
          <tr>
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
              {#each item as item}
                <td>{item}</td>
              {/each}
            </tr>
          {/each}
        </tbody>
      </table>
    {:catch error}
      <div>Error</div>
    {/await}
  </div>
</div>

<div class="modal" id="upsert-modal">
  <div class="modal-box">
    <h3 class="font-bold text-lg">Insert into {option.name.toUpperCase()}</h3>
    <ul class="flex flex-col gap-2 my-5">
      {#each optionResponse.headers as item, i}
        <input
          bind:value={dialogArr[i]}
          class="input input-bordered w-full"
          type="text"
          placeholder={item.name}
        />
      {/each}
    </ul>
    <div class="modal-action">
      <button on:click={async () => await insertData()} class="btn"
        >Submit</button
      >
      <a href="#" class="btn">Close</a>
    </div>
  </div>
</div>
