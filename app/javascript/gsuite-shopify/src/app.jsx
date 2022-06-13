import { useEffect, useState } from 'react';

const CLIENT_ID =
  '1054945649946-4708i1lg6d62jc066ct5o4o2r7cev931';

const SCOPES = [
  'https://www.googleapis.com/auth/drive.file',
  'https://www.googleapis.com/auth/userinfo.email',
  'https://www.googleapis.com/auth/userinfo.profile',
].join(' ');

export default function GoogleSignin() {
  const [gsiScriptLoaded, setGsiScriptLoaded] = useState(false);
  const [user, setUser] = useState(undefined);

  const handleGoogleSignIn = (res) => {
    if (!res.clientId || !res.credential) {
      return;
    }

    // Implement your login mutations and logic here.
    // Set cookies, call your backend, etc.

    setUser(val.data?.login.user);
  };

  const initializeGsi = () => {
    if (!window.google || gsiScriptLoaded) return;

    setGsiScriptLoaded(true);
    window.google.accounts.id.initialize({
      client_id: CLIENT_ID,
      scope: SCOPES,
      callback: handleGoogleSignIn,
    });
  };

  useEffect(() => {
    if (user?._id || gsiScriptLoaded) return;

    const script = document.createElement('script');
    script.src = 'https://accounts.google.com/gsi/client';
    script.onload = initializeGsi;
    script.async = true;
    script.id = 'google-client-script';
    document.querySelector('body')?.appendChild(script);

    return () => {
      // Cleanup function that runs when component unmounts
      window.google?.accounts.id.cancel();
      document.getElementById('google-client-script')?.remove();
    };
  }, [handleGoogleSignIn, initializeGsi, user?._id]);

  return <span className="g_id_signin">Auth</span>;
}
