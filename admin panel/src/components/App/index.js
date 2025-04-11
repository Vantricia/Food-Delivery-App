// App.js
import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes, Navigate } from 'react-router-dom';
import './app.css';
import { onAuthStateChanged, getAuth } from 'firebase/auth';

import Login from '../Login';
import Dashboard from '../Dashboard/index'; // Import the main component from the dashboard folder
import Sidebar from '../Sidebar/Sidebar';
import Analytics from '../Analytics/Analytics'; // Create this placeholder component
import Marketing from '../Marketing/marketing';
import Profile from '../profile/profile';

const App = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(null);
  const [userEmail, setUserEmail] = useState('');

  useEffect(() => {
    setIsAuthenticated(JSON.parse(localStorage.getItem('is_authenticated')));
  }, []);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(getAuth(), (user) => {
      if (user) {
        setIsAuthenticated(true);
        setUserEmail(user.email);
      } else {
        setIsAuthenticated(false);
        setUserEmail('');
      }
    });

    return () => unsubscribe();
  }, []);

  if (isAuthenticated === null) {
    return null; // or a loading spinner
  }


  return (
    <Router>
      {isAuthenticated ? (
        <div className="app-container">
          <Sidebar userEmail={userEmail} setIsAuthenticated={setIsAuthenticated}/>
          <div className="main-content">
            <Routes>
            <Route path="/profile" element={<Profile userEmail={userEmail} />} />
              <Route path="/" element={<Dashboard setIsAuthenticated={setIsAuthenticated} />} />
              <Route path="/analytics" element={<Analytics />} />
              <Route path="/marketing" element={<Marketing />}/>
              <Route path="*" element={<Navigate to="/" />} />
            </Routes>
          </div>
        </div>
      ) : (
        <Login setIsAuthenticated={setIsAuthenticated} />
      )}
    </Router>
  );
};

export default App;
