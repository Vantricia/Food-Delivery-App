import React, { useEffect, useState } from 'react';
import { NavLink } from 'react-router-dom';
import { getFirestore, collection, query, where, getDocs } from 'firebase/firestore';
import Logout from '../Logout';
import { CgProfile } from 'react-icons/cg';
import { RiDashboard2Fill } from 'react-icons/ri';
import { SiGoogleanalytics } from 'react-icons/si';
import { RiMegaphoneFill } from 'react-icons/ri';
import Profile from '../profile/prof.jpg';

const Sidebar = ({ setIsAuthenticated, userEmail }) => {
  const [username, setUsername] = useState('');

  useEffect(() => {
    const fetchUsername = async () => {
      const db = getFirestore();
      const usersCollection = collection(db, 'users');
      const q = query(usersCollection, where('email', '==', userEmail));
      const querySnapshot = await getDocs(q);

      if (!querySnapshot.empty) {
        const userDoc = querySnapshot.docs[0];
        setUsername(userDoc.data().username);
      } else {
        console.error('No such document!');
      }
    };

    fetchUsername();
  }, [userEmail]);

  return (
    <div className="sidebar">
      <nav>
        <ul>
          <header>
            <img src={Profile} className="profile-image" style={{ marginLeft: 30, marginTop: 20, marginBottom: 5 }} />
            <div className="email-container">
              {'Hi, '+ username}
              <div className="underline"></div>
            </div>
          </header>
          <li>
            <NavLink to="/profile" activeClassName="active-link">
              <CgProfile style={{ marginRight: 8, fontSize: 20 }} />
              Profile
            </NavLink>
          </li>
          <li>
            <NavLink to="/dashboard" activeClassName="active-link">
              <RiDashboard2Fill style={{ marginRight: 8, fontSize: 20 }} />
              Orders
            </NavLink>
          </li>
          <li>
            <NavLink to="/analytics" activeClassName="active-link">
              <SiGoogleanalytics style={{ marginRight: 8, fontSize: 20 }} />
              Analytics
            </NavLink>
          </li>
          <li>
            <NavLink to="/marketing" activeClassName="active-link">
              <RiMegaphoneFill style={{ marginRight: 8, fontSize: 20 }} />
              Marketing
            </NavLink>
          </li>
        </ul>
      </nav>
      <div className="logout-container">
        <Logout setIsAuthenticated={setIsAuthenticated} />
      </div>
    </div>
  );
};

export default Sidebar;
