<script lang="ts">
  import {Router, Link, Route} from 'svelte-navigator';
  import Login from './lib/routes/Login.svelte';
  import Home from './lib/routes/Home.svelte';

  async function fet() {
    const res = await fetch('http://localhost:3000/api/tables');
    return await res.text();
  }
</script>

<Router>
  <nav>
		<Link to="/">Login</Link>
		<Link to="home">Home</Link>
	</nav>
	<div>
		<Route path="/">
			<Login  />
		</Route>
		<Route path="home">
      <Home />
    </Route>
	</div>
</Router>
