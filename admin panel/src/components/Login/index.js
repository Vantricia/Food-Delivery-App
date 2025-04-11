import React, { useState } from 'react';
import Swal from 'sweetalert2';
import './login.css'

import { getAuth, signInWithEmailAndPassword } from "firebase/auth";
import { getFirestore, doc, getDoc } from 'firebase/firestore';

const Login = ({ setIsAuthenticated }) => {

  const [email, setEmail] = useState();
  const [password, setPassword] = useState();

  const handleLogin = async (e) => {
    e.preventDefault();

    const auth = getAuth();
    const firestore = getFirestore();

    if (document.activeElement.name === 'Login') {
      try {
        const userCredential = await signInWithEmailAndPassword(auth, email, password);
        const user = userCredential.user;

        // Fetch user role from Firestore
        const userDoc = await getDoc(doc(firestore, 'users', user.uid));
        const userData = userDoc.data();

        if (userData && userData.role === 'admin') {
          Swal.fire({
            timer: 1500,
            showConfirmButton: false,
            willOpen: () => {
              Swal.showLoading();
            },
            willClose: () => {
              setIsAuthenticated(true);

              Swal.fire({
                icon: 'success',
                title: 'Successfully logged in!',
                showConfirmButton: false,
                timer: 1500,
              });
            },
          });
        } else {
          await auth.signOut();
          Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: 'Only admins are allowed to log in.',
            showConfirmButton: true,
          });
        }
      } catch (error) {
        Swal.fire({
          timer: 1500,
          showConfirmButton: false,
          willOpen: () => {
            Swal.showLoading();
          },
          willClose: () => {
            Swal.fire({
              icon: 'error',
              title: 'Error!',
              text: 'Incorrect email or password.',
              showConfirmButton: true,
            });
          },
        });
      }
    }

    
  };

  return (
    <div className="small-container">
      <form onSubmit={handleLogin}>
        <h1>Admin Login</h1>
        <label htmlFor="email">Email</label>
        <input
          id="email"
          type="email"
          name="email"
          placeholder="admin@example.com"
          value={email}
          onChange={e => setEmail(e.target.value)}
        />
        <label htmlFor="password">Password</label>
        <input
          id="password"
          type="password"
          name="password"
          placeholder="qwerty"
          value={password}
          onChange={e => setPassword(e.target.value)}
        />
        <input style={{ marginTop: '12px' }} type="submit" value="Login" name="Login" />
      </form>
    </div>
  );
};

export default Login;