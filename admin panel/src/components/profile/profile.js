import './profile.css';
import { getFirestore, collection, query, where, getDocs, updateDoc } from 'firebase/firestore';
import React, { useEffect, useState } from 'react';
import Modal from '../profile/modal'; // Adjust the import path as necessary

const Profile = ({ userEmail }) => {
  const [username, setUsername] = useState('');
  const [isModalOpen, setIsModalOpen] = useState(false);

  // to display username
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

  // Handle edit username click
  const handleEditUsername = () => {
    setIsModalOpen(true);
  };

  const handleSaveUsername = async (newUsername) => {
    if (newUsername) {
      const db = getFirestore();
      const usersCollection = collection(db, 'users');
      const q = query(usersCollection, where('email', '==', userEmail));
      const querySnapshot = await getDocs(q);

      if (!querySnapshot.empty) {
        const userDoc = querySnapshot.docs[0];
        const userRef = userDoc.ref;
        await updateDoc(userRef, { username: newUsername });
        setUsername(newUsername);
        setIsModalOpen(false);
      } else {
        console.error('No such document!');
      }
    }
  };

  return (
    <div className="profile-container">
      <h1>Profile</h1>
      <div className="profile-header">
        <div className="profile-info">
          <p><strong>Email:</strong> {userEmail}</p>
          <p><strong>Username:</strong> {username}</p>
        </div>
      </div>
      <div className="profile-content">
        <section className="profile-section">
          <h2>Personal Information</h2>
          <p><strong>Email:</strong> {userEmail}</p>
          <p><strong>Phone:</strong> (123) 456-7890</p>
          <p><strong>Address:</strong> 123 Main St, Anytown, USA</p>
        </section>
        <section className="profile-section">
          <h2>Account Settings</h2>
          <button onClick={handleEditUsername}>Edit Username</button>
          <button>Change Password</button>
        </section>
        <section className="profile-section">
          <h2>Activity History</h2>
          <ul>
            <li>Logged in from IP: 192.168.1.1 on June 18, 2024</li>
            <li>Changed password on May 20, 2024</li>
            <li>Updated profile picture on April 15, 2024</li>
          </ul>
        </section>
        <section className="profile-section">
          <h2>Privacy Settings</h2>
          <p>Manage who can see your profile and activity.</p>
          <button>Adjust Privacy Settings</button>
        </section>
        <section className="profile-section">
          <h2>Connected Accounts</h2>
          <p>Connect your profile with social accounts.</p>
          <button>Connect to Facebook</button>
          <button>Connect to Google</button>
        </section>
      </div>

      <Modal 
        isOpen={isModalOpen} 
        onClose={() => setIsModalOpen(false)} 
        onSave={handleSaveUsername} 
      />
    </div>
  );
};

export default Profile;
