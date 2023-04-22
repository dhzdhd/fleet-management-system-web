<script lang="ts">
  const tables = [
    "driver",
    "vehicle",
    "trip",
    "cost",
    "vehicle_involved",
    "driver_involved",
    "driver_phone",
  ];

  interface Response {
    headers: { name: string }[];
    values: string[][];
  }

  const parse = (data: any): Response => {
    return {
      headers: data.metaData,
      values: data.rows,
    } satisfies Response;
  };

  const fetchData = async (table: string) => {
    const response = await fetch(`http://localhost:3000/api/tables/${table}`);
    const data = await response.json();

    const parsedData = parse(data);
    return parsedData;
  };

  let option: string = "driver";

  let promise = fetchData("driver");
  $: promise = fetchData(option);
</script>

<div class="h-screen w-screen flex flex-col">
  <div class="navbar bg-base-100">
    <div class="flex-1">
      <select
        bind:value={option}
        class="select select-bordered w-full max-w-xs"
      >
        {#each tables as item}
          <option value={item}>{item}</option>
        {/each}
      </select>
    </div>
    <div class="flex-none">
      <ul class="menu menu-horizontal px-1">
        <button class="btn">New record</button>
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
            {#each data.headers as item}
              <th>{item.name}</th>
            {/each}
          </tr>
        </thead>
        <tbody>
          {#each data.values as item}
            <tr class="hover">
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
