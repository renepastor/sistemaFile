export default function ({ $auth }) {
    if (!$auth.loggedIn) {
      return
    }
  
    const username = $auth.user.username
    const username2 = $auth.data.data.username
}