<script lang="ts">
  const initData = async () => {};
</script>

{#await initData}
  <div>Loading</div>
{:then value}
  <div>
    <div class="h-screen w-screen overflow-x-auto p-2">
      <table class="table w-full outline-2 outline-accent outline">
        <thead>
          <tr>
            <th />
            <th>Name</th>
            <th>Job</th>
            <th>Favorite Color</th>
          </tr>
        </thead>
        <tbody>
          <tr class="hover">
            <th>1</th>
            <td>Cy Ganderton</td>
            <td>Quality Control Specialist</td>
            <td>Blue</td>
          </tr>
          <tr class="hover">
            <th>2</th>
            <td>Hart Hagerty</td>
            <td>Desktop Support Technician</td>
            <td>Purple</td>
          </tr>
          <tr class="hover">
            <th>3</th>
            <td>Brice Swyre</td>
            <td>Tax Accountant</td>
            <td>Red</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
{:catch error}
  <div>Error</div>
{/await}
