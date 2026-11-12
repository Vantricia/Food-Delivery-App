import React, { useState, useEffect } from 'react';
import './dropdown.css';
import { IoMdArrowDropdown, IoMdArrowDropup } from 'react-icons/io';// Adjust the path as necessary
import { updateDoc, doc, getDoc, getFirestore } from 'firebase/firestore';

const Dropdown = ({ orderId, onSelect }) => {
  const [isOpen, setIsOpen] = useState(false);
  const [selectedOption, setSelectedOption] = useState(null);
  const [options, setOptions] = useState([
    { value: 'option1', label: 'Bill' },
    { value: 'option2', label: 'Bob' },
    { value: 'option3', label: 'Bon' },
    { value: 'option4', label: 'Bot' },
  ]);
  const db = getFirestore();

  useEffect(() => {
    const fetchCurrentDriver = async () => {
      const orderRef = doc(db, 'orders', orderId);
      const orderDoc = await getDoc(orderRef);
      if (orderDoc.exists()) {
        const currentDriver = orderDoc.data().driver;
        setSelectedOption({ value: orderId, label: currentDriver });
      }
    };

    fetchCurrentDriver();
  }, [orderId]);

  const handleToggle = () => {
    setIsOpen(!isOpen);
  };

  const handleSelect = async (option) => {
    setSelectedOption(option);
    setIsOpen(false);
    onSelect(option); // Callback to parent component

    // Update Firestore
    const orderRef = doc(db, 'orders', orderId);
    await updateDoc(orderRef, { driver: option.label });
  };

  return (
    <div className="dropdown">
      <button className="buttons" onClick={handleToggle}>
        {selectedOption ? selectedOption.label : 'Loading'}
        {isOpen ? <IoMdArrowDropup /> : <IoMdArrowDropdown />}
      </button>
      {isOpen && (
        <ul className="dropdown-menu">
          {options.map((option) => (
            <li key={option.value} onClick={() => handleSelect(option)}>
              {option.label}
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default Dropdown;
