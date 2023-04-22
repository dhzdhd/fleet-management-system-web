<script lang="ts">
  import { Router, Link, Route } from "svelte-navigator";
  import Login from "./lib/routes/Login.svelte";
  import Home from "./lib/routes/Home.svelte";
  import "./app.css";

  async function fet() {
    const res = await fetch("http://localhost:3000/api/tables");
    return await res.text();
  }
</script>

<main class="h-screen w-screen">
  <Router>
    <div>
      <Route path="/">
        <Login />
      </Route>
      <Route path="home">
        <Home />
      </Route>
    </div>
  </Router>
</main>
