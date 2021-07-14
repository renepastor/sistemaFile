/*export default function auth({$auth, redirect, store}) {
  console.log("###---$$$$$$---##");
  const user = $auth.user
  if (user && user.roles.includes('ROLE_ADMIN')) {
    // let the user in
  } else {
    store.dispatch('snackbar/setSnackbar', { color: 'error', text: 'Debes ser un administrador para ver esta página.' })
    redirect('/')
  }
  return;
}

export default async function ({ $auth, route, redirect, store }) {
  console.log("############",JSON.stringify($auth))
  if (!$auth.loggedIn) {
    const REDIRECT_URL = '/auth?redirect=' + route.path
    store.dispatch('snackbar/setSnackbar', { color: 'error', text: 'Debes iniciar sesión para ver esta página.' })
    redirect(REDIRECT_URL)
  }
}*/
