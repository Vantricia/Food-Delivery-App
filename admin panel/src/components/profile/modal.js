import React ,{useState}from 'react';
import './modal.css';

const Modal = ({ isOpen, onClose, onSave }) => {
  const [newUsername, setNewUsername] = useState('');

  if (!isOpen) return null;

  return (
    <div className="modal-overlay">
      <div className="modal">
        <h2>Change Username</h2>
        <input 
          type="text" 
          value={newUsername} 
          onChange={(e) => setNewUsername(e.target.value)} 
          placeholder="Enter new username" 
        />
        <div className="modal-buttons">
          <button onClick={onClose}>Cancel</button>
          <button onClick={() => onSave(newUsername)}>Save</button>
        </div>
      </div>
    </div>
  );
};

export default Modal;
